#!/system/bin/sh

MODDIR=${0%/*}

CURRENT=$(getprop persist.sys.hls.rom.operator)
[ -z "$CURRENT" ] && CURRENT="UNKNOWN"

echo "Current operator: $CURRENT"

case "$CURRENT" in
  LGU)
    OPT1="SKT"
    OPT2="KT"
    ;;
  SKT)
    OPT1="LGU"
    OPT2="KT"
    ;;
  KT)
    OPT1="LGU"
    OPT2="SKT"
    ;;
  *)
    OPT1="LGU"
    OPT2="SKT"
    ;;
esac

echo ""
echo "Choose new operator:"
echo "  Volume Up   = $OPT1"
echo "  Volume Down = $OPT2"
echo "  Press F4 to abort installation"
echo ""

chooseport() {
  echo "Waiting for Volume Up, Volume Down, or F4 key press..."

  while true; do
    # Read one key event with timeout 10 sec
    EVENT=$(timeout 10 getevent -qlc 1 2>/dev/null)

    case "$EVENT" in
      *KEY_VOLUMEUP*DOWN*)
        echo "Volume Up detected"
        return 0
        ;;
      *KEY_VOLUMEDOWN*DOWN*)
        echo "Volume Down detected"
        return 1
        ;;
      *KEY_F4*DOWN*)
        echo "Abort key (F4) detected. Aborting installation."
        exit 1
        ;;
      *)
        echo "Invalid key pressed, waiting for Volume Up, Volume Down, or F4..."
        ;;
    esac
  done
}

chooseport
RESULT=$?

if [ "$RESULT" -eq 0 ]; then
  NEW="$OPT1"
else
  NEW="$OPT2"
fi

echo "Changing operator to $NEW..."
setprop persist.sys.hls.rom.operator "$NEW"
setprop sys.hls.rom.operator "$NEW"
echo "$NEW" > "$MODDIR/operator_value"
echo "Done!"
exit 0
