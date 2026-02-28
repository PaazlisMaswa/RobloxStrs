local MathFloor,StringFormat,StringFind=math.floor,string.format,string.find

local Strs={}

function Strs.GetLines(s:string):()->(string)
	local lastBreak=0

	local function NextLine()
		if lastBreak==#s then return nil end
		local line
		local nextBreak=StringFind(s,"\n",lastBreak+1)			
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

function Strs.IsStrings(s1:string,s2:{string}):boolean
	for i,v in ipairs(s2) do if s1==v then return true end end return false
end

function Strs.ToNumberString(x:number,maxFloat:number?):string
	maxFloat=(type(maxFloat)=="number" and maxFloat>0) and maxFloat or 3
	if x==MathFloor(x) then return tostring(MathFloor(x)) end
	local s=StringFormat("%."..maxFloat.."f",x)
	s=s:gsub("%.?0+$", "")
	return s
end

return Strs
