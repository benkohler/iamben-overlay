alias upd='emerge -uDNav world --newrepo --changed-deps'
alias mt='qlop -tHvg'
alias tail-emerge-logs='tail -f $(find $(portageq envvar PORTAGE_TMPDIR)/ -name build.log)'
