#!/bin/bash

sattvik_profile_patches() {
	if [ "${FUNCNAME[1]}" != "post_src_prepare" ]; then
		eerror "You cannot call sattvik_profile_patches outside of post_src_prepare"
		return 2
	else
		local -a patches_dirs
		for profile_path in $PROFILE_PATHS; do
			local patches_dir="$profile_path/sattvik_patches"
			if [ -d "$patches_dir" ]; then
				patches_dirs+=("$patches_dir")
			fi
		done
	
		local idx
		local -a rev_patches_dirs
		for (( idx=${#patches_dirs[@]}-1 ; idx>=0 ; idx-- )); do
			rev_patches_dirs+=("${patches_dirs[idx]}")
		done
	
		local applied="${T}/sattvik_patch.log"
		[[ -e ${applied} ]] && return 2
	
		local patches_dir
		for patches_dir in "${rev_patches_dirs[@]}"; do
			local EPATCH_SOURCE check
			for check in ${CATEGORY}/{${P}-${PR},${P},${PN}}{,:${SLOT}}; do
				EPATCH_SOURCE=${patches_dir}/${CTARGET}/${check}
				[[ -r ${EPATCH_SOURCE} ]] || EPATCH_SOURCE=${patches_dir}/${CHOST}/${check}
				[[ -r ${EPATCH_SOURCE} ]] || EPATCH_SOURCE=${patches_dir}/${check}
				if [[ -d ${EPATCH_SOURCE} ]] ; then
					EPATCH_SOURCE=${EPATCH_SOURCE} \
					EPATCH_SUFFIX="patch" \
					EPATCH_FORCE="yes" \
					EPATCH_MULTI_MSG="Applying Sattvik profile patches from ${EPATCH_SOURCE} ..." \
					epatch
					echo "${EPATCH_SOURCE}" > "${applied}"
					return 0
				fi
			done
		done
	
		echo "none" > "${applied}"
		return 1
	fi
}

post_src_prepare() {
	sattvik_profile_patches
}
