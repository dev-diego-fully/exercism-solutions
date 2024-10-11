local SpaceAge = {}

local orbital_periods = {
	mercury = 0.2408467,
	venus = 0.61519726,
	earth = 1,
	mars = 1.8808158,
	jupiter = 11.862615,
	saturn = 29.447498,
	uranus = 84.016846,
	neptune = 164.79132
};

local function round(num)
	return tonumber(string.format("%.2f", num))
end


local function space_age(orbital_period, seconds)
	local earth_year_in_seconds = 31557600;
	local years = seconds/earth_year_in_seconds;
	return round(years/orbital_period)
end

local space_age_metatable = {
	__index = function(tab, key)
		return function (...)
			if string.sub(key, 0, 3) == "on_" then
				return space_age(orbital_periods[string.sub(key, 4)], tab.seconds)
			end
			return
		end
	end
}

function SpaceAge.new(_this, seconds)
	local object = {};
	object.seconds = seconds;
	setmetatable(object, space_age_metatable)
	return object;
end

return SpaceAge
