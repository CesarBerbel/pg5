unit ufpgCalcDivAvaliacaoProcModelTests;

interface

uses
  ufpgModelTests;

type
  TffpgCalcDivAvaliacaoProcModelTests = class(TfpgModelTests)
  private
    FsProcesso: string;
  protected

  public
    property fpgProcesso: string read FsProcesso write FsProcesso;
  published
  end;

implementation

end.
  
