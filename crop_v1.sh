#!/usr/bin/env bash
convert parrot_julia_logo_v1.gif -crop 385x356+77+31 +repage parrot_julia_logo_v1_crop.gif
convert parrot_julia_logo_v1.gif -transparent white parrot_julia_logo_v1_crop.gif 
