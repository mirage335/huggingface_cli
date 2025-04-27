##### Core

_special_packages() {
    export dependencies_nix_python=( "readline" )
    export packages_nix_python=( "huggingface_hub[cli]" )

    export dependencies_msw_python=( "pyreadline3" )
    export packages_msw_python=( "huggingface_hub[cli]" )
        
    export dependencies_cyg_python=( "readline" )
    export packages_cyg_python=( "huggingface_hub[cli]" )

    true
}

_huggingface_cli() {
    _special_packages

    # Discouraged. Should be preferable, more convenient, etc, to use 'huggingface-cli' already built into 'ubcp'.
    if _if_cygwin
    then
        #implies sequence
        _prepare_msw_python
        type -p huggingface-cli > /dev/null >&2
        huggingface-cli "$@"
        return
    fi

    local dumbpath_file="$scriptLocal"/"$dumbpath_prefix"dumbpath.var
    local dumbpath_contents=""
    dumbpath_contents=$(cat "$dumbpath_file" 2> /dev/null)
    if [[ "$dumbpath_contents" == "$dumbpath_file" ]]
    then
        #implies sequence
        #source "$scriptLocal"/python_nix/venv/default_venv/bin/activate
        source "$scriptLocal"/python_nix/venv/default_venv/bin/activate_nix
        #type -p huggingface-cli > /dev/null >&2
        huggingface-cli "$@"
        return
    fi

    #implies sequence
    _prepare_nix_python
    type -p huggingface-cli > /dev/null >&2
    huggingface-cli "$@"
    return
}


_test_prog() {
    # NOT tested by '_test' by default due to only novel dependencies being possibly manual dependencies.
    # Override with 'core.sh' or similar, and call with '_test_prog' or similar.
    "$scriptAbsoluteLocation" _test_special_python
}


_refresh_anchors() {
    cp -a "$scriptAbsoluteFolder"/_anchor "$scriptAbsoluteFolder"/_huggingface_cli
    cp -a "$scriptAbsoluteFolder"/_anchor.bat "$scriptAbsoluteFolder"/_huggingface_cli.bat
}
