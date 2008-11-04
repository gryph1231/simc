
# WARNING!  WARNING!  WARNING!
#
# THESE OPTIMIZATION FLAGS ARE VALID ONLY FOR SSE-ENABLED SYSTEMS!
# MOST MODERN PROCESSORS SHOULD SUPPORT SSE.
#
# WARNING!  WARNING!  WARNING!

PG   =
BITS = 32
MCP  = -msse -msse2 -mfpmath=sse
OPTS = -maccumulate-outgoing-args -O3 
SFMT = -I./sfmt 

ifneq (64,${BITS})
	OPTS += -malign-double 
endif

SRC =\
	sc_action.cpp		\
	sc_attack.cpp		\
	sc_consumable.cpp	\
	sc_druid.cpp		\
	sc_enchant.cpp		\
	sc_event.cpp		\
	sc_mage.cpp		\
	sc_option.cpp		\
	sc_pet.cpp		\
	sc_player.cpp		\
	sc_priest.cpp		\
	sc_rand.cpp		\
	sc_rating.cpp		\
	sc_report.cpp		\
	sc_shaman.cpp		\
	sc_scaling.cpp		\
	sc_sim.cpp		\
	sc_spell.cpp		\
	sc_stats.cpp		\
	sc_target.cpp		\
	sc_thread.cpp		\
	sc_unique_gear.cpp	\
	sc_util.cpp		\
	sc_warlock.cpp		\
	sc_weapon.cpp

# Multi-Platform Support
#
# if defined( __MINGW__ ) then assume Windows platform, MinGW compiler, no thread support
# else if defined( _MSC_VER ) then assume Windows platform, MS Visual Studio
# else assume POSIX compliant platform

unix opt:
	g++ -DUNIX -I. $(PG) $(MCP) $(OPTS) $(SFMT) -Wall $(SRC) -lpthread -o simcraft

debug:
	g++ -DUNIX -g -I. $(PG) $(SFMT) -Wall $(SRC) -lpthread -o simcraft

windows:
	g++ -DWINDOWS -I. $(PG) $(MCP) $(OPTS) $(SFMT) -Wall $(SRC) -o simcraft

mac:
	g++ -DMAC -arch ppc -arch i386 -I. -O3 $(SFMT) -Wall $(SRC) -o simcraft

REV=0
tarball:
	tar -cvf simcraft-r$(REV).tar $(SRC) simcraft.h sfmt/* Makefile raid_70.txt raid_80.txt
	gzip simcraft-r$(REV).tar

clean:
	rm -f simcraft
