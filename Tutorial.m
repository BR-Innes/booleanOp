%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  BOOLEAN OPERATORS (A PATRONISING MATLAB TUTORIAL)             
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% REFERENCES: 
% https://en.wikipedia.org/wiki/Boolean_algebra
% http://uk.mathworks.com/help/matlab/logical-operations.html

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  SETTING UP (AND COVERTING TO) LOGICAL ARRAYS / MATRICES               
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% You can use 'true()' or 'false()' to do this:
allTrue = true(10, 1); % column of 1s
allFalse = false(10, 1); % column of 0s 

% This works like 'zeros()' or 'ones()' but the array will be logical
% without us having to convert it (i.e. we can use it directly as an
% index). 

% For arguments sake, say we made a column with the same numbers, but 
% forgot that it should be type 'logical' and not type 'double' until some
% until we come do do our analyses:  

allOnes = ones(10, 1); % create as double
allZeros = zeros(10,1); 

% "Wait, are these logical arrays or not?" Use 'islogical()' to check!
islogical(allOnes);
islogical(allZeros); 

% "Nope!" We can save trouble now by just converting them with 'logical()'
allOnes = logical(allOnes); % convert to logical
allZeros = logical(allZeros);  

% EXERCISE 1: 
% 1: Run 'exercise1.m' - you'll get variables 'x' (data) and 'i' (an index)
% 2: Type 'getData = x(i)'; 
    % this attempt to use 'i' to index 'x' will fail: fix it! 
    % A: [6; 7; 5; 4; 9]; 

% SOLUTION(FIX): 
% islogical(i); 
% i = logical(i); 
% getData = x(i); 

% SOLUTION(WORK AROUND):
% getData = x(i==true);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   LOGICAL OPERATORS 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Set up logical values for some signals (present = 1/absent = 0) 
sOne = [true; false; true; false];
sTwo = [true; true; false; false]; 

% We can then make a truth table using the four Boolean operators:  
truAND = [sOne, sTwo, and(sOne, sTwo)]; % and (if BOTH)
truOR = [sOne, sTwo, or(sOne, sTwo)]; % or (if EITHER)
truNOT = [sOne, sTwo, not(sOne)]; % not (if NOT X e.g. not audio)
truXOR = [sOne, sTwo, xor(sOne, sTwo)]; % xor (if EITHER but not BOTH)

% You could use symbols &, |, ~ for the same effect 
% truAND = [sOne, sTwo, sOne & sTwo]; % and (if BOTH)
% truOR = [sOne, sTwo, sOne | sTwo]; % or (if EITHER)
% truNOT = [sOne, sTwo, ~sOne]; % not (if NOT X e.g. not audio)
% truXOR = [sOne, sTwo, ~(sOne == sTwo)]; 

% EXERCISE 2:
% Here's 4 trials-worth of data, along with what stimuli was present:
expData = [130; 146; 127; 189]; 
colour = [true; false; true; false];
moving = [true; true; false; false];
% You can also get this by running 'exercise2.m'

% We want to use the operators above to work out the sum of the data when:
% 1. Both stimuli were present (conjunction) 
% 2. Any stimulus was present (disjunction) 
% 3. Only a moving stimulus was present (negation) 
% 4. When either stimulus was present, but not both 

% SOLUTION: 
% sumAND = sum(expData(and(colour, moving))); % A: 130
% sumOR = sum(expData(or(colour, moving))); % A: 403
% sumNOT = sum(expData(not(colour))); % A: 335
% sumXOR = sum(expData(xor(colour, moving))); % A: 273


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   ANY, ALL, & FIND 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% The functions 'any' and 'all' can be used to check the values in your
% arrays/matrices. 
% 'any' - returns '1' if any non-zero elements/true at all
% 'all' - returns '1' if all are non-zero elements/true

allTrue = true(10, 1); 
allFalse = false(10, 1); 

any(allTrue); % returns 1
any(allFalse); % returns 0 
all(allTrue); % returns 1
all(allFalse); % returns 0

% If a non-zero sneaks into your allFalse array, you'll detect it...: 
allFalse(5) = true; 
any(allFalse); % returns 1

% ...and you can hunt it down with 'find'...:
liar = find(allFalse); 

% ...and kill it (politely request that it changes). 
allFalse(liar) = false; 

% EXERCISE 3: 
% Imagine are measuring change in a variable over time, trying to detect
% some experimental event, similar to a spike in a neuron or an eye
% movement. 
% Use 'exercise3.m' to get the timestamps and the corresponding data values

% expEvent: 
% Column 1 is timestamps
% Column 2 is data value

% We want to get certain timestamps to use for indexing later. 
% 1. Can we get all the timestamps for when the event is happening?
% 2. Can we get the timepoints for when the data exceeds a criteron value?
    % e.g. only timestamps when datapoint is > 20? 
% 3. Can we get the start and end timepoints only?
% 4. Can we rewrite the code to avoid a crash if no event occurs?

% SOLUTION
% 1. expEventTS = expEvent(find(expEvent(:, 2)), 1); % A: 63:67
% 2. expEventTSC = expEvent(find(expEvent(:, 2)>20), 1); % A: 64:66
% 3. expEventStart = expEvent(find(expEvent(:, 2), 1, 'first'), 1); % A: 63
%    expEventEnd = expEvent(find(expEvent(:, 2), 1, 'last'), 1); % A: 67
%    OR could use min/max on expEventsTS
%    expEventStartEnd = [min(expEventTS), max(expEventTS)]; 
% 4. We could use 'any()' within an if-loop: 
%    if any(expEvent(:, 2))
%       disp('beep-boop'); % you'd put actual code here though  
%    end 
