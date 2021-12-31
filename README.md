# Alasoo Group Onboarding Repository
This repository is home to the onboarding information for the [Alasoo group](https://kauralasoo.github.io/) at the Univeristy of Tartu. See onboarding.md for the general onboarding information. Below is the list of other useful quides and resources.

## Resources

* [Executing Nextflow workflows at the University of Tartu HPC](resources/nextflow.md)
* [Best Practices for Working with Controlled Access Human Genetic Data](resources/controlled_access_data.md)
* [Building and using Docker containers with Singularity](resources/building_containers.md)
* [Introdocution to Nextflow DSL2](https://www.youtube.com/watch?v=-Ne4OP0aiYw&t=422s)

Inspired by a similary repository by the [Greene Lab](https://github.com/greenelab/onboarding)

## Opinionated list of useful software tools
* if you want to connect to HPC without typing your password everytime check out [this](https://superuser.com/questions/8077/how-do-i-set-up-ssh-so-i-dont-have-to-type-my-password)
* [Forklift](https://binarynights.com/) - Transfering and editing files over SSH
* [GitHub Desktop](https://desktop.github.com/) - A good user interface for git.
* [Spectacle](https://www.spectacleapp.com/) - A good window locator for MacOS
* [iTerm2](https://iterm2.com/) - A good terminal option for MacOS. (features like: smart Paste, password manager, splitPane etc.) 
* [CSVTK](https://bioinf.shenwei.me/csvtk/) - excellent tool to work with CSV/TSV files, comes in handy in both HPC and local
* [Alfred App](https://www.alfredapp.com/) - Spotlight search on Steroids on MacOS
* [Visual Studio Code with following extensions](https://code.visualstudio.com/) - A good text editor for code.
  * [Nextflow](https://marketplace.visualstudio.com/items?itemName=nextflow.nextflow)
  * [Remote - SSH](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-ssh-edit)
  * [Rainbow CSV](https://marketplace.visualstudio.com/items?itemName=mechatroner.rainbow-csv)
  * [File Utils](https://marketplace.visualstudio.com/items?itemName=sleistner.vscode-fileutils)
  * [Sort lines](https://marketplace.visualstudio.com/items?itemName=Tyriar.sort-lines)
  * [Markdown All in One](https://marketplace.visualstudio.com/items?itemName=yzhang.markdown-all-in-one)
  * [filesize](https://marketplace.visualstudio.com/items?itemName=mkxml.vscode-filesize)
  * [Insert Numbers](https://marketplace.visualstudio.com/items?itemName=Asuka.insertnumbers)
  * [GitLens](https://marketplace.visualstudio.com/items?itemName=eamodio.gitlens)


## Bash aliases and styling 
```bash
# User specific aliases and functions
alias squeme='squeue -u {your_username}'
alias scancelme='scancel -u {your_username}'
alias lll='ls -lah'
alias llt='ls -lct'
alias a='echo "------------Your aliases------------";alias'
alias ldir='ls -l | grep ^d'
alias ..='cd ..'
alias ...='cd ../../'
alias topme='top -U {your_username}'
alias sc='screen -r'
alias lss='less -S'
alias stg='ssh stage1'
alias loadmods='module load java-1.8.0_40; module load singularity/3.5.3; module load nextflow'
track_jobid() {
  sacct -j "$1" --format=User,JobID,Jobname,partition,state,time,start,end,elapsed,MaxRss,MaxVMSize,nnodes,ncpus,nodelist,ExitCode
}

export PS1='\[\033[1;32m\][\u@\h]\[\033[1;34m\] \W\[\033[1;34m\] \$ \[\033[0m\]'
export NXF_OPTS='-Xms1g -Xmx4g'
```
