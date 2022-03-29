if not table.pack then table.pack = function(...) return { n = select("#", ...), ... } end end
if not table.unpack then table.unpack = unpack end
local load = load if _VERSION:find("5.1") then load = function(x, n, _, env) local f, e = loadstring(x, n) if not f then return f, e end if env then setfenv(f, env) end return f end end
local _select, _unpack, _pack, _error = select, table.unpack, table.pack, error
local _libs = {}
local _3d_1, _3c3d_1, _3e3d_1, _2b_1, len_23_1, getIdx1, setIdx_21_1, error1, require1, setmetatable1, type_23_1, format1, unpack1, n1, splice1, apply1, type1, traceback1, demandFailure_2d3e_string1, _2a_demandFailureMt_2a_1, demandFailure1, nth1, push_21_1, list_2d3e_struct1, self1, mbuttons1, wrapper1, rb1, _5f_G1, _5f_print1, mode1, switchMode1, ps1, stack1, home1, menu1
_3d_1 = function(v1, v2) return v1 == v2 end
_3c3d_1 = function(v1, v2) return v1 <= v2 end
_3e3d_1 = function(v1, v2) return v1 >= v2 end
_2b_1 = function(x, ...) local t = x + ... for i = 2, _select('#', ...) do t = t + _select(i, ...) end return t end
len_23_1 = function(v1) return #v1 end
getIdx1 = function(v1, v2) return v1[v2] end
setIdx_21_1 = function(v1, v2, v3) v1[v2] = v3 end
error1 = error
require1 = require
setmetatable1 = setmetatable
type_23_1 = type
format1 = string.format
unpack1 = table.unpack
n1 = function(x)
  if type_23_1(x) == "table" then
    return x["n"]
  else
    return #x
  end
end
splice1 = function(xs)
  local parent = xs["parent"]
  if parent then
    return unpack1(parent, xs["offset"] + 1, xs["n"] + xs["offset"])
  else
    return unpack1(xs, 1, xs["n"])
  end
end
apply1 = function(f, ...)
  local _n = _select("#", ...) - 1
  local xss, xs
  if _n > 0 then
    xss = {tag="list", n=_n, _unpack(_pack(...), 1, _n)}
    xs = select(_n + 1, ...)
  else
    xss = {tag="list", n=0}
    xs = ...
  end
  return f(splice1((function()
    local _offset, _result, _temp = 0, {tag="list"}
    _temp = xss
    for _c = 1, _temp.n do _result[0 + _c + _offset] = _temp[_c] end
    _offset = _offset + _temp.n
    _temp = xs
    for _c = 1, _temp.n do _result[0 + _c + _offset] = _temp[_c] end
    _offset = _offset + _temp.n
    _result.n = _offset + 0
    return _result
  end)()
  ))
end
type1 = function(val)
  local ty = type_23_1(val)
  if ty == "table" then
    return val["tag"] or "table"
  else
    return ty
  end
end
traceback1 = debug and debug.traceback
demandFailure_2d3e_string1 = function(failure)
  if failure["message"] then
    return format1("demand not met: %s (%s).\n%s", failure["condition"], failure["message"], failure["traceback"])
  else
    return format1("demand not met: %s.\n%s", failure["condition"], failure["traceback"])
  end
end
_2a_demandFailureMt_2a_1 = {__tostring=demandFailure_2d3e_string1}
demandFailure1 = function(message, condition)
  return setmetatable1({tag="demand-failure", message=message, traceback=(function()
    if traceback1 then
      return traceback1("", 2)
    else
      return ""
    end
  end)(), condition=condition}, _2a_demandFailureMt_2a_1)
end
nth1 = function(xs, idx)
  if idx >= 0 then
    return xs[idx]
  else
    return xs[xs["n"] + 1 + idx]
  end
end
push_21_1 = function(xs, ...)
  local vals = _pack(...) vals.tag = "list"
  if not (type1(xs) == "list") then
    error1(demandFailure1(nil, "(= (type xs) \"list\")"))
  end
  local nxs = n1(xs)
  xs["n"] = (nxs + n1(vals))
  local forLimit = n1(vals)
  local i = 1
  while i <= forLimit do
    xs[nxs + i] = vals[i]
    i = i + 1
  end
  return xs
end
list_2d3e_struct1 = function(list)
  if not (type1(list) == "list") then
    error1(demandFailure1(nil, "(= (type list) \"list\")"))
  end
  local out = {}
  local forLimit = n1(list)
  local i = 1
  while i <= forLimit do
    out[i] = nth1(list, i)
    i = i + 1
  end
  return out
end
self1 = function(x, key, ...)
  local args = _pack(...) args.tag = "list"
  return apply1(x[key], x, args)
end
require1("actions")
mbuttons1 = require1("menubuttons")
wrapper1 = require1("wrapper")
rb1 = wrapper1["rb"]
_5f_G1 = wrapper1["_G"]
_5f_print1 = require1("print")
_5f_print1["clear"]()
_5f_print1["opt"]["overflow"]("auto")
mode1 = nil
switchMode1 = function(nmode)
  mode1 = _5f_G1[nmode]
  return nil
end
ps1 = rb1["lcd_puts"]
stack1 = {tag="list", n=0}
push_21_1(stack1, 1)
push_21_1(stack1, 2)
push_21_1(stack1, 3)
push_21_1(stack1, 4)
push_21_1(stack1, 5)
push_21_1(stack1, 6)
push_21_1(stack1, 7)
push_21_1(stack1, 8)
push_21_1(stack1, 9)
push_21_1(stack1, 10)
home1 = {}
home1[mbuttons1["LEFT"]] = function()
  return _5f_print1["f"]("symbol")
end
home1[mbuttons1["RIGHT"]] = function()
  return _5f_print1["f"]("number")
end
home1["draw"] = function()
  self1(rb1, "lcd_clear_display")
  local i = 1
  while i <= 15 do
    ps1(0, i, "│")
    i = i + 1
  end
  local i = 1
  while i <= 15 do
    ps1(29, i, "│")
    i = i + 1
  end
  local i = 1
  while i <= 15 do
    ps1(39, i, "│")
    i = i + 1
  end
  ps1(0, 0, "┌────────────────────────────┬─────────┐")
  ps1(0, 14, "├────────────────────────────┼─────────┤")
  ps1(0, 16, "└────────────────────────────┴─────────┘")
  return self1(rb1, "lcd_update")
end
mode1 = home1
menu1 = function()
  local options = list_2d3e_struct1({tag="list", n=4, "cancel", "clear entry", "reset", "quit"})
  local choice = 1 + rb1["do_menu"]("RPN-Ipod menu", options, nil, false)
  if choice == 1 then
    return switchMode1("home")
  elseif choice == 2 then
    return nil
  elseif choice == 3 then
    return nil
  elseif choice == 4 then
    return require1("os")["exit"]()
  else
    _error("unmatched item")
  end
end
while true do
  local action = rb1["get_plugin_action"](-1)
  if action == mbuttons1["EXIT"] then
    require1("os")["exit"]()
  elseif action == mbuttons1["CANCEL"] then
    menu1()
  elseif mode1[action] then
    mode1[action]()
  end
  mode1["draw"]()
end
