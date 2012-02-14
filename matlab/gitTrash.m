function gitTrash(currentBranch)
comm = 'git checkout -b trash';         eval(comm);
comm = 'git status';                    eval(comm);
comm = 'git commit -a -m "trash"';      eval(comm);
comm = ['git checkout ' currentBranch]; eval(comm);
comm = 'git branch -D trash';           eval(comm);
