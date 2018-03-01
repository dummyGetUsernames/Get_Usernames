
THE PROBLEM STATEMENT:

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
