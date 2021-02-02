const puppeteer = require("puppeteer");
const fs = require("fs");
const PNG = require("pngjs").PNG;

function sleep(ms) {
  return new Promise((resolve) => setTimeout(resolve, ms));
}

const URL = process.env.URL || "CHANGEME";

(async () => {
  const browser = await puppeteer.launch({
    args: ["--no-sandbox", "--disable-setuid-sandbox"],
  });

  const page = await browser.newPage();

  /* Kindle 4 NT resolution */
  await page.setViewport({ width: 600, height: 800 });

  /* Might want to use networkidle0 here, depending on the type of page */
  /* See https://github.com/puppeteer/puppeteer/blob/main/docs/api.md */
  await page.goto(URL, { waitUntil: "networkidle2" });

  /* This is a bit silly. ¯\_(ツ)_/¯
  Networkidle2 doesn't always seem to wait long enough. */
  await sleep(3000);

  await page.screenshot({ path: "dash.png" });

  await fs.createReadStream("dash.png")
    .pipe(new PNG({ colorType: 0 }))
    .on("parsed", function () {
      this.pack().pipe(fs.createWriteStream("dash.png"));
    });

  browser.close();
})();
