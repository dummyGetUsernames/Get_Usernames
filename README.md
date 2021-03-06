
THE PROBLEM STATEMENT:

It doesn't seem to be possible, either using the advanced search features, or the API, to directly look up a github username by a known email address, if that user has chosen not to make that email address public.
But, if they've associated it with their account, even if they haven't made it public, then git commits that they've made to repositories, that use that email address, are linked to their user accounts. And, as it happens, when you access the commits of that repo with the API, the usernames show up there, too. So, as a part of the ranking candidates for hiring process, seeing github stats was one of the few things we tried looking into, to see how uch a candidate is active and how many contributoins they have made publically.

The functional specifications of the script are as follows:

1. Grab a candidate's github profile given an email address
2. Pull from github are data such as a candidate's contribution stats, the types of 
   repository they contribute to and their own public repositories along with their public repositories' stats.

Business value of having such data points:
1. Clients who have access to such data points can make better hiring decisions
2. Similarly, some of these data points become part of the inputs to better our ranking algorithms.

Technical value of such a feature:
Having an existing codebase that pulls data from external sources will definitely help us leverage on the codebase 
to pull data from other sources.

CONCEPT USED:

Github commit can be done using any username on any file without any authentication, 
but for github push we need to have a github account credentials where we are pushing.

1)getUsernames.sh - This file contains the actual script to get the required features
including: usernames for people, their repositories and their repositories statistics in a file/folder format.

2) EmailIdList.txt- This is a text file containing the email-addresses of people list one per 
line to be given getUsernmaes while running.

OUTPUT FOLDERS:
1)userRepoStats - containing all the stats for all the repositories for all the userns whose email-ids are provided.
2)userRepoTypes - containig the repository files with names of the username which have the list of the repositories for that usernae. 


OUTPUT FILES:
1)commitedUsername.txt - containing the usernames for the all the users which was earlier unknown, with which now we will 
                        get the stats information using github API.
2)$username_reposData.txt - containing the json forat of all the stats we got from the github API.                    


Resources used:
1. https://developer.github.com/v3/
