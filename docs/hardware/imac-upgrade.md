---
title: iMac G5 Screen Upgrade
description: Step-by-step guide to upgrading an iMac G5 17" (iSight, 2006) — adding RAM, SSD, and replacing the screen with full photos and part references.
tags:
  - apple
  - vintage
  - ssd
  - lcd
  - imac
---

I recently performed some hardware upgrades on an [iMac G5 1.9 GHz 17"
(iSight)][1] from late 2005, and I thought I’d share some insight into the
process, some pictures, as well as the final result.

The original idea was to replace the screen, which was suffering from the
infamous “vertical lines” issue, with a new one. Then I thought I'd take this
opportunity to also upgrade the RAM from 1.5 to 4.5 GB, and replace the 3.5" HDD
with a 2.5" SSD.

![vertical-lines-screen](../assets/imac/00-vertical-lignes.jpg)

## Buying new hardware

### RAM

As stated on the EveryMac.com website, the official maximum amount of RAM
supported is 2.5 GB (the internal 512 MB and an extra 2 GB RAM module). However,
as also noted there, it’s very well possible to put a 4 GB RAM module.

The RAM module should have the following specs: _4 GB Samsung 2Rx4
PC2-6400U-666_. After some online digging, I settled for the one in the picture
below, which I ordered on [eBay][3] for $13:

![ram-module](../assets/imac/00-ram-module.jpg)

### SSD

I initially put a Crucial MX500 SSD in the iMac, only to find that it wasn’t
recognized by Disk Utility. I tried again with a Samsung 870 EVO 500 GB and it
worked perfectly. Cost: $62.

### Screen

I bought the _661-3789 Apple LCD Display Panel_ on [DV Warehouse][7] for $89
plus $112 for shipping!

Total cost of the upgrades: $276.

## Performing upgrades

### Overview

On [this page][4], we can find all iFixit guides for this iMac. However, we are
mostly interested in the one for the [RAM replacement][2], the [hard drive
replacement][6], and the [screen replacement][5].

These guides are a great resource, so read them carefully! The guides make it
look easy, but it’s not so and lots of patience is needed. Removing the white
case is a bit of a pain, and disconnecting the iSight camera is equally tricky.
Removing the screen is fine, but putting in the new one and reassembling the
iMac is the biggest hurdle. Oh, and be mindful not to drop any of the screen
screws behind the motherboard!

Changing the RAM doesn’t require opening up the iMac completely, so it can be
done either before or after changing the screen and SSD. In order to remove the
hard drive, you’ll first need to disconnect the screen. For these reasons, I
suggest the following order of things:

1. Upgrade the RAM.
2. Open up the iMac: remove the white case, disconnect the iSight camera, and
   the screen to have access to the hard drive.
3. Replace the old hard drive with the new 2.5" SSD and secure it with some good
   duct tape so it doesn’t move. Be sure to reattach the hard drive’s thermal
   sensor on the SSD, otherwise the iMac’s fans may run at full speed
   constantly.
4. *This step isn’t shown in the iFixit guide*: you’ll need to disassemble the
   “structure” around the old screen and put it on the new screen, so that the
   new screen can be screwed back into the iMac (see pictures below).
5. Reassemble the iMac.
6. Format the SSD and install Mac OS X. Important: see next section A note on software.
7. Enjoy!

There are some good YouTube videos showing how to disassemble and reassemble the
iMac. Two of them below:

<div class="video-wrapper">
    <iframe width="100%" src="https://www.youtube.com/embed/_ux2cA7IHbA?si=17RYMPU4dTP0jpGR" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>
</div>
<br/>
<div class="video-wrapper">
    <iframe width="100%" src="https://www.youtube.com/embed/g1x4OBZG0U4?si=FLwokLuRlCjuE1d7" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>
</div>

### Pictures

Before the upgrade: 1.5 GB of RAM and vertical lines everywhere on the screen.
![screen-vertical-lines](../assets/imac/01-screen-lines.jpg)

Inside the iMac, before the hard drive removal…
![opened-up-hd](../assets/imac/10-opened-up-with-hard-drive.jpg)

… and after.
![opened-up-without-hd](../assets/imac/20-opened-up-without-hard-drive.jpg)

Overview.
![overview](../assets/imac/30-opened-up-overview.jpg)

The front and back of the original screen.
![front-old-screen](../assets/imac/35-old-screen.jpg)
![back-old-screen](../assets/imac/36-old-screen-back.jpg)

The new screen, notice the absence of the metallic structure and cables that are
still on the old screen.
![front-new-screen](../assets/imac/40-new-screen.jpg)
![back-new-screen](../assets/imac/45-new-screen-back.jpg)

Some close ups of the original screen.
![screen-details-0](../assets/imac/50-screen-details.jpg)
![screen-details-1](../assets/imac/51-screen-details.jpg)
![screen-details-2](../assets/imac/52-screen-details.jpg)
![screen-details-4](../assets/imac/54-screen-details.jpg)
![screen-details-5](../assets/imac/55-screen-details.jpg)
![screen-details-6](../assets/imac/56-screen-details.jpg)

The new screen with the metallic structure and cables around it.
![new-screen-before-assembly](../assets/imac/60-new-screen-before-assembly.jpg)

After the structure has been screwed in. Tape everything.
![new-screen-after-assembly](../assets/imac/62-new-screen-assembly.jpg)

The EMI shield was also moved from the original screen to the new one (the black
one, as well as the silver ones on the sides).
![new-screen-assembly-front](../assets/imac/63-new-screen-assembly-front.jpg)

Is it really working?! Time to install Mac OS X on the SSD. This was quite a
pain, as my optical drive worked only about 10% of the time.
![reinstall](../assets/imac/80-reinstall.jpg)

500 GB SSD, 4.5 GB of RAM and a new screen!
![final-specs](../assets/imac/99-final-specs.jpg)

## A note on software

### Disk Utility

One important thing to keep in mind before formatting the new SSD: Disk Utility
in Tiger doesn’t support creating additional partitions without erasing the
existing one.

So if you plan to first install Tiger and then add a second partition for
Leopard, make sure to create both from the start — unless you have a Leopard
install disc, in which case you’ll be able to modify the partition table later
without wiping the drive.

### HTTPS browser for Tiger

Safari in Tiger doesn’t support modern TLS versions, so most HTTPS websites
won’t load. Alternatives include [TenFourFox][9] (a fork of Firefox) and
[InterWebPPC][9] (a fork of TenFourFox). Both are discontinued, but
InterWebPPC’s latest version (from 2023) is a bit more recent.

Browsing the web using InterWebPPC on Tiger
![interwebppc-tiger](../assets/imac/90-interwebppc.jpg)

### Shuriken and Sorbet Leopard

[Shuriken][10] is a collection of scripts for Tiger, mainly aimed at improving
system performance. [Sorbet Leopard][11] is a modified version of Leopard that
includes updated certificates, performance tweaks, and other patches. Both were
created by the same developer but are no longer maintained.

Content of Shuriken
![shuriken-content](../assets/imac/95-shuriken.jpg)

The Sorbet App Store on Sorbet Leopard (the Keychron K3 works on both Tiger and Leopard)
![sorbet-leopard](../assets/imac/96-sorbet-leopard.jpg)

## Conclusion

I’d been meaning to tackle these upgrades for years, and it’s deeply satisfying
to see this iMac running smoothly again!

[1]: https://everymac.com/systems/apple/imac/specs/imac_g5_1.9_17.html
[2]: https://ifixit.com/Tutoriel/iMac+G5+17-Inch+Model+A1144+RAM+Replacement/938
[3]: https://www.ebay.com/itm/113861832392
[4]: https://ifixit.com/Device/iMac_G5_17%22_Model_A1144
[5]: https://ifixit.com/Tutoriel/iMac+G5+17-Inch+Model+A1144+Display+Replacement/942
[6]: https://ifixit.com/Tutoriel/iMac+G5+17-Inch+Model+A1144+Hard+Drive+Replacement/948
[7]: https://www.dvwarehouse.com/661-3789-apple-lcd-display-panel-for-imac-g5-17-isight-1-9ghz.html
[8]: http://www.tenfourfox.com/
[9]: https://macintoshgarden.org/apps/interwebppc-browser-a-rebrand-of-tenfourfox-the-future
[10]: https://macintoshgarden.org/apps/shuriken
[11]: https://macintoshgarden.org/apps/sorbet-leopard
