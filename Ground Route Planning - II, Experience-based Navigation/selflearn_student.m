%Tested on Matlab R2021a Academic Use
%% Prepararion for a new run

prompt = 'Clear ruleTable? [Y/N]';
str = input(prompt,'s');
if(upper(str)=='N')
    clearvars -except ruleTable
    disp(ruleTable)
else
    clear all;
    disp('ruleTable empty')
end
close all; clc

%% Basemaps
map=imread('32d.png');
obstacles=0;
%map=imread('32.png');
%ruleTable=eye(4);
%obstacles=1;

%% "defines"
%cell values
emptyVal=0;
finishVal=-1;
robotVal=-2;
pathVal=-2.5;
obstacleVal=-3;

%rule table size (movement and direction possibilities - min: 4x4)
directions=4;
movements=4;

%directions (where is the finish cell)
dirRight=1;
dirLeft=2;
dirUp=3;
dirDown=4;

%movements (where to move)
moveRight=1;
moveLeft=2;
moveUp=3;
moveDown=4;

if (exist('ruleTable')==0)    
    ruleTable=zeros(directions,movements);
end

%% get start and finish positions
%find R
startPos=[-1,-1]; %invalid
for (i=1:size(map,1))
    for (j=1:size(map,2))
        if reshape(map(i,j,:),[1 3])==[255,0,0] %red
            startPos=[i,j];
        end
    end
end

%find F
finishPos=[-1,-1]; %invalid
for (i=1:size(map,1))
    for (j=1:size(map,2))
        if reshape(map(i,j,:),[1 3])==[0,255,0] %green
            finishPos=[i,j];
        end
    end
end

disp(['start coords: ', num2str(startPos)]);
disp(['finish coords: ', num2str(finishPos)]); 

%% Replace start, finish, obstacle cell values
map=rgb2gray(map);
map=1-im2double(map);
map(finishPos(1), finishPos(2))=finishVal; %finish
map(startPos(1), startPos(2))=robotVal; %start
for (i=1:size(map,1))
    for (j=1:size(map,2))
        if map(i,j)==1
            map(i,j)=obstacleVal; %obstacle
        end
    end
end

%% let's learn!
robotPos=startPos;

while(norm(robotPos)~=norm(finishPos))
   
    newPos=robotPos;
    directionIndex=-1;
 
    % Problem #1  
    % directionIndex, i.e. determination of the direction of 
    % the target relative to the robot
 
    % decide direction
   
    
   
   
   
   
   
    
    disp(directionIndex)
    
    % Problem #2
    % movementIndex, i.e. the selection of the best step for 
    % the given direction from the rule table
    
   
    
    
    
    
    
    % Problem #3   
    % the calculation of the new step, i.e. incrementing and 
    % decrementing the row/column of the variable "newPos"
    
    
    
    
    
    

    
    % Problem #4
    % Distance Check 
    % if we got close => confirm the rule 
    % if we moved away => weaken the rule

    
    
    
    
    
    
  % In case of Obstacles: move if new position is empty, step back otherwise
  
  if obstacles==0
      map(robotPos(1),robotPos(2))=pathVal;
      robotPos=newPos;
      map(robotPos(1),robotPos(2))=robotVal;
  else
      if (map(newPos(1),newPos(2))==emptyVal) || (map(newPos(1),newPos(2))==finishVal)
          map(robotPos(1),robotPos(2))=pathVal;
          prevPos=robotPos;
          robotPos=newPos;
          map(robotPos(1),robotPos(2))=robotVal;
      else
          map(robotPos(1),robotPos(2))=pathVal;
          [robotPos,prevPos]=deal(prevPos,robotPos)
          map(robotPos(1),robotPos(2))=robotVal;
      end
  end
    
  %display movement
    disp(ruleTable);
    imagesc(map);
    colormap(jet);
    axis square;
    pause(0.5);

 end

%% Retry    
prompt = 'Retry? [Y/N]';
str = input(prompt,'s');
if(upper(str)=='Y')
    selflearn_student
end