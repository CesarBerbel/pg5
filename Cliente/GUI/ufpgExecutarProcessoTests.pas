unit ufpgExecutarProcessoTests;

interface

uses
  ufpgGuiTestCase;

type
  TffpgExecutarProcessoTests = class(TfpgGuiTestCase)
  public
    procedure SetUp; override;
  published
    procedure LimparVariaveis;
  end;

implementation

uses
  ufpgFuncoesGUITestes, Windows, ufpgVariaveisTestesGUI;

{ TffLimparVariaveisTests }

procedure TffpgExecutarProcessoTests.LimparVariaveis;
begin

end;

procedure TffpgExecutarProcessoTests.SetUp;
begin
  spCarregarDadosSetUp := False;
  inherited;
end;

end.

