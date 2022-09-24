public enum TimeUnit {
   SECONDS,
   MINUTES
}

type Levels record {
    int deep;
    int wake;
    int light;
};

type SleepSummary record{
  string date;
  int duration;
  Levels levels;
};


type SummaryLevel record {
    int minutes;
    int thirtyDayAvgMinutes;
};

type Summary record {
    SummaryLevel deep;
    SummaryLevel light;
    SummaryLevel wake;
};

type LevelsJson record {
    Summary summary;
};

type Sleep record {
    string date;
    int duration;
    LevelsJson levels;
};