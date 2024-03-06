import aiohttp
import aiofiles
import asyncio
from bs4 import BeautifulSoup
import json
import time
from tenacity import retry, stop_after_attempt, wait_fixed

# Specify your input and output file paths here
INPUT_FILE_PATH = 'Snopes_Url_fake.json'
OUTPUT_FILE_PATH = 'Snopes_Fake.json'

@retry(stop=stop_after_attempt(3), wait=wait_fixed(2))
async def fetch_url(session, url):
    async with session.get(url, headers={'User-Agent': 'Mozilla/5.0'}) as response:
        if response.status != 200:
            raise Exception(f"Request failed with status code: {response.status}")
        return await response.text()

async def read_json_file(file_path):
    try:
        async with aiofiles.open(file_path, 'r', encoding='utf-8') as file:
            content = await file.read()
            return json.loads(content) if content.strip() else []
    except FileNotFoundError:
        print(f'Error: File {file_path} not found.')
        return []
    except json.JSONDecodeError:
        print(f'Error: File {file_path} is empty or contains invalid JSON data.')
        return []

async def scrape_and_update(url, session):
    try:
        print(f"Scraping URL: {url}")
        html = await fetch_url(session, url)
        soup = BeautifulSoup(html, 'html.parser')

        main_container = soup.find('main', id='article_main')

        if main_container:
            title = main_container.find('section', class_='title-container').find('h1').text
            fact = main_container.find('section', class_='title-container').find('h2').text
            published_date = main_container.find('div', class_='published_date').find('h3').text

            image_link = ''
            article_img_div = main_container.find('div', class_='article_img')
            if article_img_div:
                image_tag = article_img_div.find('img')
                if image_tag:
                    image_link = image_tag['src']

            claim = main_container.find('div', class_='claim_cont').text.strip()

            async with aiofiles.open(OUTPUT_FILE_PATH, 'r', encoding='utf-8') as f:
                existing_data = await f.read()

            try:
                existing_data = json.loads(existing_data) if existing_data else []
            except json.JSONDecodeError:
                print(f"Error: Invalid JSON data in {OUTPUT_FILE_PATH}. Resetting the file.")
                existing_data = []

            data = {
                'Sr No': get_last_sr_no(existing_data),
                'url': url,
                'title': title,
                'fact': fact,
                'published_date': published_date,
                'image_link': image_link,
                'claim': claim,
                'Label': "Fake"
            }

            json_data = json.dumps(data, ensure_ascii=False)
            async with aiofiles.open(OUTPUT_FILE_PATH, 'a', encoding='utf-8') as f:
                await f.write(json_data + "\n")

            print(f'Data successfully scraped and added to {OUTPUT_FILE_PATH} for URL: {url}')
            time.sleep(1)  # Add a 1-second delay
        else:
            print(f'Main container not found on the page for URL: {url}')
    except Exception as e:
        print(f'Error while scraping URL: {url}, Exception: {str(e)}')

async def main(input_file_path, output_file_path):
    urls_to_scrape = await read_json_file(input_file_path)

    if not urls_to_scrape:
        print(f"No URLs to scrape in {input_file_path}.")
        return

    # Clear the output file before writing new data
    async with aiofiles.open(output_file_path, 'w', encoding='utf-8') as f:
        pass

    print(f"Found {len(urls_to_scrape)} URLs to scrape.")

    async with aiohttp.ClientSession() as session:
        tasks = [scrape_and_update(url, session) for url in urls_to_scrape]
        await asyncio.gather(*tasks)

    print("Scraping completed.")
def get_last_sr_no(data):
    if data:
        return data[-1].get("Sr No", 0) + 1
    else:
        return 1  # Start from 1 if no data is available
    
asyncio.run(main(INPUT_FILE_PATH, OUTPUT_FILE_PATH))