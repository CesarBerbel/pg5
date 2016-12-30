unit ufpgLimparVariaveisTests;

interface

uses
  ufpgGuiTestCase;

type
  TffLimparVariaveisTests = class(TfpgGuiTestCase)
  public
    procedure SetUp; override;
  published
    procedure LimparVariaveis;
  end;

implementation

uses
  ufpgFuncoesGUITestes, Windows, uspVerificadorTelas, ufpgVariaveisTestesGUI;

{ TffLimparVariaveisTests }

procedure TffLimparVariaveisTests.LimparVariaveis;
begin
  gbErroTest := False;
  LimparArrayProcesso;
  sleep(1000);
  LimparVariaveisExternas;
  sleep(1000);
  spVerificadorTelas.FecharTelasAbertas;
end;

procedure TffLimparVariaveisTests.SetUp;
begin
  gbErroTest := False;
  spCarregarDadosSetUp := False;
  inherited;
end;

end.

