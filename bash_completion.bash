#to load complete command in zsh shell
autoload bashcompinit && bashcompinit

_bmx_cl_ruby()
{
    local cur prev

    cur=${COMP_WORDS[COMP_CWORD]}
    prev=${COMP_WORDS[COMP_CWORD-1]}

    case ${COMP_CWORD} in
        1)
            COMPREPLY=($(compgen -W "config host user repo issue offer contract position escrow event cache" -- ${cur}))
            ;;
        2)
            case ${prev} in
                config)
                    COMPREPLY=($(compgen -W "help show set" -- ${cur}))
                    ;;
                host)
                    COMPREPLY=($(compgen -W "help info ping counts next_week_ends increment_day_offset increment_hour_offset set_current_time rebuild" -- ${cur}))
                    ;;
                user)
					COMPREPLY=($(compgen -W "help list show create deposit withdraw" -- ${cur}))
                    ;;
                repo)
					COMPREPLY=($(compgen -W "help list show create sync" -- ${cur}))
                    ;;
                issue)
					COMPREPLY=($(compgen -W "help list show offers contract sync" -- ${cur}))
                    ;;
                offer)
					COMPREPLY=($(compgen -W "help list show create_buy create_sell create_clone create_counter take cancel" -- ${cur}))
                    ;;
                contract)
					COMPREPLY=($(compgen -W "help list show create clone cancel cross resolve series escrows ammendments positions open_offers" -- ${cur}))
                    ;;
                position)
					COMPREPLY=($(compgen -W "help show" -- ${cur}))
                    ;;
                escrow)
					COMPREPLY=($(compgen -W "help show" -- ${cur}))
                    ;;
                event)
					COMPREPLY=($(compgen -W "help list update" -- ${cur}))
                    ;;
                cache)
					COMPREPLY=($(compgen -W "help list show clear length value" -- ${cur}))
                    ;;
            esac
            ;;
        *)
            COMPREPLY=()
            ;;
    esac
}

complete -F _bmx_cl_ruby bmx_cl_ruby
