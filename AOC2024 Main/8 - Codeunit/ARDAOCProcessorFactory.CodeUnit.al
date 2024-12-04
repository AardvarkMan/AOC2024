codeunit 82027 ARD_AOCProcessorFactory
{

    /// <summary>
    /// Retrieves the appropriate Advent of Code processor for the specified day.
    /// </summary>
    /// <param name="Day">The day for which the processor is to be retrieved.</param>
    /// <returns>An interface to the Advent of Code processor for the specified day.</returns>
    procedure GetProcessor(Day: Integer): interface ARD_AdventOfCodeProcessor
    var
        Day1: CodeUnit ARD_AOC202401;
        Day2: CodeUnit ARD_AOC202402;
        Day3: Codeunit ARD_AOC202403;
        Day4: Codeunit ARD_AOC202404;
    begin
        case Day of
        1:
            exit(Day1);
        2:
            exit(Day2);
        3:
            exit(Day3);
        4:
            exit(Day4);
        end;
    end;
}
