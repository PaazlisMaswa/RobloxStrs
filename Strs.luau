local Strs={}

function Strs.GetLines(s:string)
	local lastBreak=0

	local function NextLine()
		if lastBreak==#s then return nil end

		local line
		local nextBreak=string.find(s,"\n",lastBreak+1)			

		if nextBreak then
			line=s:sub(lastBreak+1,nextBreak-1)
			lastBreak=nextBreak
		else
			line=s:sub(lastBreak+1,#s)
			lastBreak=#s
		end

		return line
	end

	return NextLine
end

function Strs.IsStrings(s1,s2)
	for i,v in ipairs(s2) do if s1==v then return true end end return false
end

function Strs.IsEmpty(s:string):boolean
	return type(s)~='string' or s:match(' ')
end

function Strs.ToPersentase(x:number,max:number?,formatString:string?):string
	if (x>=math.huge or x<=-math.huge) then return '∞%' end
	if x==0 then return '0%' end
	formatString=formatString or '%.2f%%'
	if x<=-1 then 
		formatString='-'..formatString 
	end
	local persentase=max and (math.floor(x/max))*100 or math.floor(x)*100
	if formatString=='NO' then
		return max and `{persentase}%` or `{persentase}%`
	end
	return max and string.format(formatString,persentase) or string.format(formatString,persentase)
end

local Suffixes={' ','K','M','B','T','Qd','Qn','Sx','Sp','Oc','No','De','UDe','DDe','TDe','QdDe','QnDe','SxDe','SpDe','OcDe','NoDe','Vg','UVg','DVg','TVg'}

function Strs.FormatNumber(x:number):string
	local isNegative=x<=0
	x=math.abs(x)
	local s=tostring(x)
	for i=1,#Suffixes do
		if x<10^(i*3) then
			local v=x/(10^((i-1)*3)/100)
			local result=tostring(math.floor(v)/100)..Suffixes[i]
			return isNegative and '-'..result or result
		end
	end
	return isNegative and '-'..s or s
end

function Strs.FormatClockNumber(x:number,mode:number):string
	local result='0'
	if x<=0 then 
		if mode==1 then
			result='00:00'
		elseif mode==2 then
			result='00:00:00'
		elseif mode==3 then
			result='00:00:00:00'
		elseif mode==0 then
			result='0'
		else
			result='0'
		end
		return result
	end
	local days=math.floor(x/86400)
	local hours=math.floor((x%86400)/3600)
	local minutes=math.floor((x%3600)/60)
	local secs=x%60
	result=string.format('%02i:%02i',minutes,secs)
	if mode==1 then
		result=string.format('%02i:%02i',minutes,secs)
	elseif mode==2 then
		result=string.format('%02i:%02i:%02i',hours,minutes,secs)
	elseif mode==3 then
		result=string.format('%02i:%02i:%02i:%02i',days,hours,minutes,secs)
	elseif mode==0 then
		result=tostring(x)
	else
		result=tostring(minutes)
	end
	return result
end

function Strs.ToMS(x:number):string
	if (x>=math.huge or x<=-math.huge) then return '∞' end
	local seconds=x%60
	local minutes=math.floor(x/60)%60
	return string.format('%02i:%02i',minutes,seconds)
end

function Strs.ToHMS(x:number):string
	if (x>=math.huge or x<=-math.huge) then return '∞' end
	local seconds=x%60
	local minutes=math.floor(x/60)%60
	local hours=math.floor(x/60^2)
	return string.format('%02i:%02i:%02i',hours,minutes,seconds)
end

function Strs.ToDHMS(x:number):string
	if (x>=math.huge or x<=-math.huge) then return '∞' end
	local seconds=x%60
	local minutes=math.floor(x/60)%60
	local hours=math.floor(x/60^2)%24
	local days=math.floor(x/86400)
	return string.format('%02i:%02i:%02i:%02i',days,hours,minutes,seconds)
end

function Strs.Split(s:string):string
	
end
return Strs
