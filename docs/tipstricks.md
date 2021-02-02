# Tips & tricks

## Producing dashboard images from a webpage

A common way to produce dashboard images for the Kindle is to take a screenshot of a website.
This can be done in a variety of ways. A few things to keep in mind are:

1. The images should be grayscale PNG images, without any alpha layers.
2. The resolution should match the display resolution of the Kindle. For example the Kindle 4 NT has a resolution of 800x600 pixels.

I personally use a headless Chrome instance with [Puppeteer](https://pptr.dev/).
The code I use can be found [here](./screenshotter/screenshot.js) as a reference.
