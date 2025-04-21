alias upd='emerge -uDNav world --newrepo --changed-deps'
alias mt='qlop -tHvg'
alias tail-emerge-logs='tail -f $(find $(portageq envvar PORTAGE_TMPDIR)/ -name build.log)'
alias gentoo-pull="git pull --rebase-merges origin master"
alias gentoo-push="git push --signed origin master"

eb() {
	vi $(equery w -m $1)
}

mynspawn() {
	mkdir -p ${1}/var/db/repos/gentoo
	systemd-nspawn \
		--bind=/var/db/repos/gentoo \
		--bind=/var/db/repos/iamben-overlay \
		-D ${@}
}
