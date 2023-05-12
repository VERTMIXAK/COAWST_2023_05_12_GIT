#!/bin/bash

SRC=/import/c1/VERTMIX/jgpender/coawst
DEST=/import/VERTMIXFS/jgpender/COAWST_2023_05_12_GIT_fastNdirty

rsync  -P -v -r -a --rsh="/usr/bin/rsh" 			\
				--exclude=coawstG*					\
			 	--exclude=coawstM* 					\
                --exclude=coawstROM*                \
                --exclude=coawst_*                  \
				--exclude=romsG 					\
				--exclude=romsM 					\
                --exclude=temp.*                    \
                --exclude=roms.*                    \
				--exclude=log* 						\
            	--exclude=log.*         			\
                --exclude=log_*                     \
				--exclude=*.nc 						\
				--exclude=*.mat*  					\
				--exclude=*.asc                     \
				--exclude=*.nc*  					\
                --exclude=psdem*                    \
                --exclude=fort*                     \
                --exclude=DATA         				\
				--exclude=Build						\
                --exclude=WPS                       \
                --exclude=WRF                       \
                --exclude=WW3                       \
                --exclude=Sandy                     \
                --exclude=.*.mat*      				\
                --exclude=.*.dat_*					\
                --exclude=Junk	      				\
				--exclude=.jgp						\
				--exclude=ocean*.in_*				\
                --exclude=*.tar		               	\
                --exclude=*.Z                     	\
                --exclude=*.gz                    	\
                --exclude=*.save                  	\
                --exclude=gmeta               		\
				--exclude=BoB4_4km_WW3only*         \
                --exclude=scheduleForDeletion*   	\
	--rsync-path=/usr/local/bin/rsync $SRC $DEST  > myRsync.log

