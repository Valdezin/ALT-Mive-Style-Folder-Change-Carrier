#!/system/bin/sh

MODDIR=${0%/*}

ui_print() {
  echo "$1"
}

CURRENT=$(getprop persist.sys.hls.rom.operator)
[ -z "$CURRENT" ] && CURRENT="UNKNOWN"

ui_print "Current operator: $CURRENT"

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

ui_print ""
ui_print "Choose a new operator:"
ui_print "  Volume Up   = $OPT1"
ui_print "  Volume Down = $OPT2"
ui_print "  F4 (Abort)  = Cancel install"
ui_print ""

chooseport() {
  ui_print "Waiting for key press..."

  while true; do
    EVENT=$(getevent -qlc 1)
    case "$EVENT" in
      *KEY_VOLUMEUP*DOWN*)
        ui_print "Volume Up pressed"
        return 0  # means choose OPT1
        ;;
      *KEY_VOLUMEDOWN*DOWN*)
        ui_print "Volume Down pressed"
        return 1  # means choose OPT2
        ;;
      *KEY_F4*DOWN*)
        ui_print "Abort key (F4) pressed. Aborting installation."
        exit 1
        ;;
      *)
        # Ignore other keys/events
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

ui_print "Changing operator to $NEW..."
setprop persist.sys.hls.rom.operator "$NEW"
setprop sys.hls.rom.operator "$NEW"
echo "$NEW" > "$MODDIR/operator_value"
ui_print "Operator changed to $NEW!"

# Signal successful installation
exit 0
