# Low-power Kindle dashboard

Turns out old Kindle devices make great, energy efficient dashboards :-)

![](./example/photo.jpg)

## What this repo is

This repo only contains the code that runs on the Kindle. It periodically fetches an image to be displayed on the screen and suspends the device to RAM (which is very power efficient) until the next screen update.

This code _does not_ render the dashboard itself. It's expected that what to display on the screen is rendered elsewhere and can be fetchd via HTTP(s). This is both more power efficient and allows you to use any tool you like to produce the dashboard image.

In my case I use a [dashbling](https://github.com/pascalw/dashbling) dashboard that I render into a PNG screenshot on a server. See [here](https://github.com/pascalw/kindle-dash/blob/main/docs/tipstricks.md#producing-dashboard-images-from-a-webpage) for information on how these PNGs should be produced, including some sample code.

## Prerequisites

* A jailbroken Kindle, with Wi-Fi configured.
* An SSH server on the Kindle (via [USBNetwork](https://wiki.mobileread.com/wiki/USBNetwork))
* Tested only on a Kindle 4 NT. Should work on other Kindle devices as well with minor modifications.

## Installation

1. Download the [latest release](https://github.com/pascalw/kindle-dash/releases) on your computer and extract it.
2. Modify `local/fetch-dashboard.sh` and optionally `local/env.sh`.
3. Copy the files to the Kindle, for example: `rsync -vr ./ kindle:/mnt/us/dashboard`.
4. Start dashboard with `/mnt/us/dashboard/start.sh`.  
   Note that the device will go into suspend about 10-15 seconds after you start the dashboard.

## Upgrading

If you're running kindle-dash already and want to update to the latest version follow the following steps.

1. Download the [latest release](https://github.com/pascalw/kindle-dash/releases) on your computer and extract it.
2. Review the release notes. Some releases might require changes to files in `local/`.
3. Copy the files to the Kindle, excluding the `local` directory. For example: `rsync -vur --exclude=local ./ kindle:/mnt/us/dashboard`.
4. Modify files in `/mnt/us/dashboard/local` if applicable.
5. Start dashboard with `/mnt/us/dashboard/start.sh`.  
   Note that the device will go into suspend about 10-15 seconds after you start the dashboard.
   
## KUAL

If you're using KUAL you can use simple extension to start this Dashboard

1. Copy folder `kindle-dash` from `KUAL` folder to the kual `extensions` folder. (located in `/mnt/us/extensions`)

## How this works

* This code periodically downloads a dashboard image from an HTTP(s) endpoint.
* The interval can be configured in `dist/local/env.sh` using a cron expression.
* During the update intervals the device is suspended to RAM to save power.

## Notes

* The releases contain a pre-compiled binary of the [ht](https://github.com/ducaale/ht) command-line HTTP client. This fully supports modern HTTPS crypto, wheras the built-in `curl` and `wget` commands don't (because they rely on a very old `openssl` library).

## Credits

Thanks to [davidhampgonsalves/life-dashboard](https://github.com/davidhampgonsalves/life-dashboard) for the inspiration!
