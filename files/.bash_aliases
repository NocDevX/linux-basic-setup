# Uso geral
apache-folder() {
    path="/var/www/html"

    if [ $1 ]; then
        path="${path}/${1}";
    fi;

    cd $path;
}

documents-folder(){
    path="/home/$(whoami)/Doc*";

    if [ $1 ]; then
        path="$path/$1";
    fi

    cd $path;
};

# Para projetos com code sniffer
psr-fix() {
    psr_check_command="./vendor/bin/phpcbf --standard=PSR12 ${1}";

    if [ $2 ]; then
        psr_check_command="./vendor/bin/phpcbf --standard=${2} ${1}";
    fi

    eval $psr_check_command;
}

psr-check() {
    psr_check_command="./vendor/bin/phpcs --standard=PSR12 ${1}";

    if [ $2 ]; then
        psr_check_command="./vendor/bin/phpcs --standard=${2} ${1}";
    fi

    eval $psr_check_command;
}

git-cleanup() {
    main_branch="master"

    if [ -z "${1}" ]; then
        echo "Usar branch padrÃ£o? (master)";
        read use_default_branch;

        if [ "$use_default_branch" != "y" ] && [ "$use_default_branch" != "s" ]; then
            echo "Digite o nome da branch alvo: ";
            read main_branch;
        fi
    fi

    if [ $1 ]; then
        main_branch="${1}"
    fi

    eval "git branch --merged $main_branch | egrep -v '(^\*|$main_branch)' | xargs git branch -D"
}