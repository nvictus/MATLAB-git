function git(varargin)
% A thin MATLAB wrapper for Git.
% 
%   Short instructions:
%       Use this exactly as you would use the OS command-line verison of Git.
% 
%   Long instructions are:
%       This is not meant to be a comprehensive guide to the near-omnipotent 
%       Git SCM:
%           http://git-scm.com/documentation
% 
%       Common MATLAB workflow: 
% 
%       % Creates initial repository tracking all files under some root
%       % folder
%       >> cd ~/
%       >> git init
%
%       % Shows changes made to all files in repo (none so far)
%       >> git status
%
%       % Create a new file and add some code
%       >> edit foo.m
%
%       % Check repo status, after new file created
%       >> git status
%
%       % Stage/unstage files for commit
%       >> git add foo.m          % Add file to repo or to stage
%       >> git reset HEAD .       % To unstage your files from current commit area
%
%       % Commit your changes to a new branch, with comments
%       >> git commit -m 'Created new file, foo.m'
% 
%       % Other useful commands (replace ellipses with appropriate args)
%       >> git checkout ...       % To restore files to last commit
%       >> git branch ...         % To create or move to another branch
%       >> git diff ...           % See line-by-line changes 
%
%   Useful resources:
%       1. GitX: A visual interface for Git on the OS X client
%       2. Github.com: Remote hosting for Git repos
%       3. Git on Wikipedia: Further reading 
% 
% v0.1,     27 October 2010 -- MR: Initial support for OS X & Linux,
%                               untested on PCs, but expected to work
% 
% v0.2,     11 March 2011   -- TH: Support for PCs
% 
% v0.3,     12 March 2011   -- MR: Fixed man pages hang bug using redirection
% 
% Contributors: (MR) Manu Raghavan
%               (TH) Timothy Hansell

% BUG: Redirection to TYPE command on Windows fails because TYPE does not
% accept input from stdin. Regarding v0.3, Windows git seems to launch the 
% default webbrowser to view man pages so the hang bug may not apply.
% 31 May 2012 -- NA: Eliminated redirection on PCs

arguments = cell2mat(...
                cellfun(@(s)([s,' ']),varargin, 'UniformOutput',false));
if ispc
  [status, result] = system(['git ',arguments]);
else
  [status, result] = system(['git ',arguments,' | cat']);
end
% if git is in the path this will return a status of 0 or 128
% depending on whether we are sitting in a repository or not
% it will return a 1 only if the command is not found

if (status==1)
    % If GIT Is NOT installed, then this should end the function.
    fprintf('git is not installed\n%s\n',...
           'Download it at http://git-scm.com/download');
else
    disp(result)
end

end
