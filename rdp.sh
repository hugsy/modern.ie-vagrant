#!/bin/bash -eux
set -o pipefail

vagrant rdp -- /cert:ignore /w:1920 /h:1080 /smart-sizing
