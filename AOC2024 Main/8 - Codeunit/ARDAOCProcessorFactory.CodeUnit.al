codeunit 82027 ARD_AOCProcessorFactory
{
    procedure GetProcessor(Day: Integer): interface ARD_AdventOfCodeProcessor
    var
        Day1: CodeUnit ARD_AOC202401;
        Day2: CodeUnit ARD_AOC202402;
        Day3: Codeunit ARD_AOC202403;
    begin
        case Day of
        1:
            exit(Day1);
        2:
            exit(Day2);
        3:
            exit(Day3);
        end;
    end;
}
