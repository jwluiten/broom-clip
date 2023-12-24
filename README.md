# Customizable [openSCAD](https://openscad.org) broom clip

This customizable broom clip is my first try at an openSCAD design.
It uses [catchnhole](https://github.com/mmalecki/catchnhole) developed by Maciej Małecki.

I printed multiple of these clips on  my QIDI X Max-3, using UltraABS-GF25.

## Cloning and adding the `catchnhole` sub module
Start by cloning this repository:
```bash
git clone git@github.com:jwluiten/broom-clip.git
cd broom-clip
```

Without adding `catchnhole` the clip will render without the hole for the screw. To correctly render the clip, the `catchnhole` submodule must be updated as follows:

```bash
git submodule update --init
```

## Customizable features

### inner diameter of the clip
As inner diameter of the clip I used the clip thickness as measured using a caliper. This results in clips that are strong enough for my purposes.

### clip thickness
For clip thickness I used 2.5. This, combined with a well measured inner diameter, creates clips with a tight grip.

### opening angle of the clip
I used 110º for the opening angle. Inserting the broom requires force. In retrospect 120º might have been a better choice.

### pin diameter
A pin is added to both open ends of the clip. This parameter sets the diameter of the pin.

### clip height
For light objects I used 15, for heavier objects 20. The greater the height, the better the grip of the clip on the broom.

### block thickness
At the end of the clip, a block is appended. This parameter sets the thickness of that block. The total thickness at the wall-side of the clip is `clip thickness + block thickness`.

### bolt name
I used M5. That corresponds to 4.5mm screws that need 6mm plugs. The smallest type in [this bundle](https://www.amazon.nl/dp/B08BS2SXWD?psc=1&ref=ppx_yo2ov_dt_b_product_details).
Please note that `catchnhole` is based on ISO standard bolts, not screws. Hence the M5 value for a 4.5 mm screw which has a counter sink diameter of 8.7mm.
