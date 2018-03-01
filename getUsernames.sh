# This contains the confiure params:api-link and other authentication credentials 
configure() 
{
    repo=Get_Usernames
    username=dummyGetUsernames
    pass=charu231
    website="https://github.com/"
    url="$website$username/$repo"
    api="https://api.github.com"
    scriptPath="`pwd`"
    [ -f ~/.netrc ] || touch ~/.netrc
    grep "github.com" ~/.netrc > /dev/null || echo "machine github.com login $username password $pass" > ~/.netrc 
    [ -d ${scriptPath}/userRepoTypes ] || mkdir ${scriptPath}/userRepoTypes
    [ -d ${scriptPath}/userRepoStats ] || mkdir ${scriptPath}/userRepoStats
	#check if there exist the .netrc file for os to directly read for GITHUB account creditials if not then echo it
 	#ref:https://stackoverflow.com/questions/6565357/git-push-requires-username-and-password
    
}


# this fucntion extract-usernames using git-api resulting in a json file which is then text edit  # it using sed,uniq,sort commands so as
# to get only username from the json file and saving it in the new file name 
# commitedUsername.txt-showing all commits including previous commits. 
extractUsernames()
{
    curl ${api}/repos/${username}/${repo}/commits | sed "s/,/,\n/g" | grep login  | sort | uniq | cut -f2 -d":" | \
    sed "s/\"//g; s/,n//g; s/ //g; /$username/d; /web-flow/d" > ${scriptPath}/commitedUsername.txt
}



# This will extract repository names and result a json file which is then text-edit it using 
# grep,cut,sed commands 
# to get repo-name and save it in a file ${user}_repositoryName for each user listed in 
# commitedUsername.txt. Here a folder is made:userRepoTypes in which we have files 
# user_repositoryName having a list of repos listed.
extractrepoTypes()
{
    while read user
    do
    repoUrl=${api}/users/${user}/repos
    curl ${repoUrl} > ${scriptPath}/${user}_reposData.txt #making file outside repoistory
    cat ${scriptPath}/${user}_reposData.txt | grep -w "\"name\"" | cut -f2 -d":" | sed "s/ //g; s/\"//g; s/,//g;" > ${scriptPath}/userRepoTypes/${user}_repositoryName
 	[ -d ${scriptPath}/userRepoStats ] || mkdir ${scriptPath}/userRepoStats #/${user}_repoStats
	done < ${scriptPath}/commitedUsername.txt

}


# This will extract stats info using github-api in a json format.
# This requires username which we get from commitedUsername.txt made in extractUsername() and 
# also repository name which is made in extractrepoTypes() function.The json file is stored in #$user_$repo_repoData.txt for each repo and each user 
extractRepoStats()
{
    while read user
    do
        while read repoName
        do
            repoUrl=${api}/repos/${user}/${repoName}/contributors
			curl ${repoUrl} > ${scriptPath}/userRepoStats/${user}_${repoName}_reposData.txt
        done < ${scriptPath}/userRepoTypes/${user}_repositoryName 
    done < ${scriptPath}/commitedUsername.txt
}

main()
{
    configure && echo "configuration Completed!" || echo "configuration Failed!!!"#check configure is working properly or not
    usersList="../$1" #takiung input file-list of emails listed line-by-line.
    git clone ${url} #cloning the repository
    cd ${repo}
    #making a dummy repo on the account and commiting using each email id listed in the input file.
    while read emailid
    do
	    echo "dummy data: "${emailid} > dummyFile1.txt #add comment
        git add . 
        git commit --author "dummy name <$emailid>" -m "dummy commits" 
        git push origin master #pushing the dummt file made to owned repository
    done < ${usersList} && echo "Completed Successfully!!!"
    cd ..
    extractUsernames && echo "extractUsernames Completed!" || echo "extractUsernames Failed!!!"
    extractrepoTypes && echo "extractrepoTypes Completed!" || echo "extractrepoTypes Failed!!!"
    extractRepoStats && echo "extractRepoStats Completed!" || echo "extractRepoStats Failed!!!"
    rm -rf $repo #delete the repo made.    
}

main $1

