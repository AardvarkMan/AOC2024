codeunit 82027 ARD_AOCProcessorFactory
{
    procedure GetProcessor(Day: Integer): interface ARD_AdventOfCodeProcessor
    var
        Day1: CodeUnit ARD_AOC202301;
        Day2: CodeUnit ARD_AOC202302;
    begin
        case Day of
        1:
            exit(Day1);
        2:
            exit(Day2);
        end;
    end;
}
