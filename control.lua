script.on_configuration_changed(
  function()
    for redacted, theForce in pairs(game.forces) do
      for k, v in pairs(theForce.technologies) do
        if v.researched then
          for k2, v2 in pairs(v.prototype.effects) do
            if v2.recipe then
              theForce.recipes[v2.recipe].enabled = true
            end
          end

          local prot = v.prototype
          if v and v.research_unit_ingredients then
            local promethium_found = false
            for k, v in pairs(prot.research_unit_ingredients) do
              if v.name == "promethium-science-pack" and v.amount > 0 then
                promethium_found = true
              end
            end

            if promethium_found then
              theForce.recipes["reference-car"].enabled = true
            end
          end
        end
      end
    end
  end
)

remote.add_interface("LasingAround-Milestones", {
    milestones_preset_addons = function()
        return {
            ["Lasing Around"] = {
                required_mods = {"LasingAroundMk2"},
                milestones = {
                    {type="group", name="Resources"},
                    {type="fluid",  name="helium", quantity=1},
                    {type="group", name="Progress"},
                    {type="technology", name="laser-mill", quantity=1}
                }
            }
        }
    end
})


local function HiddenUnlock(event)
  local tech = event.research
  local prot = tech.prototype
  if prot and prot.research_unit_ingredients then
    local promethium_found = false
    for k, v in pairs(prot.research_unit_ingredients) do
      if v.name == "promethium-science-pack" and v.amount > 0 then
        promethium_found = true
      end
    end

    if promethium_found and tech.force.technologies["lasingaround-easter-egg"] then
      tech.force.technologies["lasingaround-easter-egg"].researched = true
    end
  end
end

script.on_event(
  {defines.events.on_research_finished},
  HiddenUnlock
)