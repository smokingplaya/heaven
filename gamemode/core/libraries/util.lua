if (!printBackup) then
  printBackup = print

  ---@param ... any
  function print(...)
    local args = {...}

    if (#args == 0) then
      return printBackup("nil value")
    end

    for _, value in ipairs(args) do
      if type(value) == "table" then
        PrintTable(value)
        continue;
      end

      printBackup(value)
    end
  end
end