# META NAME colored chords
# META DESCRIPTION plugin - colorize msg, signal cords and boxes 
# META DESCRIPTION a simple and probably not very useful pd-gui-plugin
# META AUTHOR <chri_le_roux> chri_le_roux@gmx.net
# META VERSION 0.1

package require Tcl 8.5

namespace eval ::coloredcords:: {
	variable ::coloredcords::config
}
# default colors 
set ::coloredcords::config(msg_color) "#3399cc"
set ::coloredcords::config(msg_color_highlight) "#a7d5ed"
set ::coloredcords::config(signal_color) "#f65b16"
set ::coloredcords::config(color_mixed_inlet) "green"

proc ::coloredcords::init {} {
    ::coloredcords::read_config
    ::coloredcords::set_msg_colors
    ::coloredcords::set_signal_colors

	# write to log
	# ::pdwindow::post "loaded coloredcords-plugin\n\n"
}

# set the msg color from config file
proc ::coloredcords::set_msg_colors {} {
	set ::msg_cord_highlight $::coloredcords::config(msg_color)
	set ::msg_cord $::coloredcords::config(msg_color)
	set ::msg_nlet $::coloredcords::config(msg_color)
	set ::msg_box_fill $::coloredcords::config(msg_color_highlight)
}

# set signal color from config file
proc ::coloredcords::set_signal_colors {} {
	set ::signal_cord_highlight $::coloredcords::config(signal_color)
	set ::signal_cord $::coloredcords::config(signal_color)
	set ::signal_nlet $::coloredcords::config(signal_color)
}
 
proc ::coloredcords::set_mixed_inlet_color {} {
	set :mixed_nlet $::coloredcords::config(color_mixed_inlet)
}

# copied from kiosk plugin by IOhannes
proc ::coloredcords::read_config {{filename colored_cords.cfg}} {
    if {[file exists $filename]} {
        set fp [open $filename r]
    } else {
        set filename [file join $::current_plugin_loadpath $filename]
        if {[file exists $filename]} {
            set fp [open $filename r]
        } else {
            puts "colored_cords.cfg not found"
            return False
        }
    }
    while {![eof $fp]} {
        set data [gets $fp]
        if { [string is list $data ] } {
            if { [llength $data ] > 1 } {
                set ::coloredcords::config([lindex $data 0]) [lindex $data 1]
            }
        }
    }
    close $fp
    return True
}

# main
::coloredcords::init