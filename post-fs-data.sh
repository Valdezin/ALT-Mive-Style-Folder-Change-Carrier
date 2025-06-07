#!/system/bin/sh

MODDIR=${0%/*}

if [ -f "$MODDIR/operator_value" ]; then
  OPERATOR=$(cat "$MODDIR/operator_value")
  setprop persist.sys.hls.rom.operator "$OPERATOR"
  setprop sys.hls.rom.operator "$OPERATOR"
fi
