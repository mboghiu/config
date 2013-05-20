
# Define GIT PS1
__my_git_ps1 ()
{
    local b="$(git symbolic-ref HEAD 2>/dev/null)";
    if [ -n "$b" ]; then
        printf ":(%s)" "${b##refs/heads/}";
    fi
}

# Define function to grab files captured by grep
grepf()
{
    grep -r "$1" $2 | grep --invert-match "^Binary.*" | sed 's/:.*//' | uniq
}
