unit ufpgCadUnificacaoTests;

interface

uses
  ufpgGUITestCase, ufpgDataModelTests, ufpgCadUnificacaoModelTests, ufpgCadUnificacao;

type
  TffpgCadUnificacaoTests = class(TfpgGUITestCase)
  private
    FoTela: TffpgCadUnificacao;
    FoDados: TffpgCadUnificacaoModelTests;
    procedure UnificacaoDeProcessos;
    procedure PreencherDados;
  public
    function PegarClasseModelTests: TfpgDataModelTestsClass; override;
  published
    procedure TestarUnificacaoProcessos;
  end;


implementation

uses
  TestFrameWork, uspInterface, usajConstante, ufpgFuncoesGUITestes;

{ TffpgRelDemoDistribTests }

function TffpgCadUnificacaoTests.PegarClasseModelTests: TfpgDataModelTestsClass;
begin
  result := TffpgCadUnificacaoModelTests;
end;

procedure TffpgCadUnificacaoTests.TestarUnificacaoProcessos;
begin
  ExecutarRoteiroTestes(UnificacaoDeProcessos);
end;

procedure TffpgCadUnificacaoTests.UnificacaoDeProcessos;
begin
  AbrirTela;
  FoTela := TffpgCadUnificacao(spTela);
  FoDados := TffpgCadUnificacaoModelTests(spDataModelTests);

  PreencherDados;

  FoTela.ccCadastro.Execute(acSalvar);

  FecharTela;
  check(FoDados.VerificaProcessoUnificado(FoDados.fpgNuProcessoUnificar),
    'O processo (' + FoDados.fpgNuProcessoUnificar +
    ') não foi unificado conforme verificação em Banco');
end;

procedure TffpgCadUnificacaoTests.PreencherDados;
begin
  if (FoDados.fpgNuProcessoPrinc = STRING_INDEFINIDO) and
    (FoDados.fpgNuProcessoUnificar = STRING_INDEFINIDO) then
  begin
    FoDados.fpgNuProcessoPrinc := UsarProcessoArray;
    FoDados.fpgNuProcessoUnificar := UsarProcessoArray;
    check((FoDados.fpgNuProcessoPrinc <> STRING_INDEFINIDO) and
      (FoDados.fpgNuProcessoUnificar <> STRING_INDEFINIDO), 'Processos não cadastrados');
  end;

  if FoDados.fpgRegistraMsgPartes then
	spVerificadorTelas.RegistrarMensagem(
    	'As partes presentes no processo a ser unificado que*', 'Sim');
  EnterTextInto(FoTela.dfnuProcesso.FdfNumeroProcessoExterno, FoDados.fpgNuProcessoPrinc);
  EnterTextInto(FoTela.dfNuProcessoApenso.FdfNumeroProcessoExterno, FoDados.fpgNuProcessoUnificar);
end;

end.

