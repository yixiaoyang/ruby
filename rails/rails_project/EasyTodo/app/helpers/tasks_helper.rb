module TasksHelper
    def getStatsStr(stats)
    if stats == 0
      return "New Task"
    elsif stats == 1
      return "Finished"
    end
  end
end
