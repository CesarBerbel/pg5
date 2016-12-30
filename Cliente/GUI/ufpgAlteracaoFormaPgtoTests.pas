unit ufpgAlteracaoFormaPgtoTests;

interface

uses
  ufpgGUITestCase, ufpgAlteracaoFormaPgtoModelTests, ufpgAlteracaoFormaPgto, ufpgDataModelTests;

type
  TffpgAlteracaoFormaPgtoTests = class(TfpgGUITestCase)
  private
    FoDados: TffpgAlteracaoFormaPgtoModelTests;
    FoTela: TffpgAlteracaoFormaPgto;
    FsNuMandado: string;
    procedure AlteracaoFormaPgto;
    procedure PreencherAlteracaoFormaPgto;
    //    procedure SelecionarNaGrid(const poWindow: IWindow);
  protected
    function PegarClasseModelTests: TfpgDataModelTestsClass; override;
  public
    procedure TearDown; override;
    property fpgNuMandado: string read FsNuMandado write FsNuMandado;
  published
    procedure TestarAlteracaoFormaPgto;
  end;

implementation

uses
  uspInterface, usmdSelecionaMandado, ufpgConstanteGUITests, ufpgFuncoesGUITestes;

procedure TffpgAlteracaoFormaPgtoTests.TestarAlteracaoFormaPgto;
begin
  ExecutarRoteiroTestes(AlteracaoFormaPgto);
end;

{ Comentado para caso precise selecionar um manbdado específico em processos com mais de um mandado
procedure TffpgAlteracaoFormaPgtoTests.SelecionarNaGrid(const poWindow: IWindow);
var
  oSelecionaMandado: TfsmdSelecionaMandado;
begin
  oSelecionaMandado := TfsmdSelecionaMandado(TspForm(poWindow.AsControl));
  oSelecionaMandado.grFiltro.spEncolhida := False;
  oSelecionaMandado.grFiltro.SelectedIndex := 0;
  EnterTextInto(oSelecionaMandado.grFiltro, FsNuMandado);
  if oSelecionaMandado.grDados.Fields[0].AsString = FsNuMandado then
    oSelecionaMandado.ccCadastro.Execute(acSelecionar);
end;}

procedure TffpgAlteracaoFormaPgtoTests.PreencherAlteracaoFormaPgto;
begin
  if FoDados.fpgNuProcesso = STRING_INDEFINIDO then
    FoDados.fpgNuProcesso := usarProcessoArray;
  check(FoDados.fpgNuProcesso <> STRING_INDEFINIDO, 'Número de Processo não encontrado');

  EnterTextInto(FoTela.smdNumeroMandado.sajNumeroProcesso.FdfNumeroProcessoExterno,
    FoDados.fpgNuProcesso, False);

  EnterTextInto(FoTela.smdFormaPgtoConsNova.dfCodigo, FoDados.fpgCdFormaPgto);
  Tab;

  if FoDados.fpgAlterarParaMesmaFormaPagto then
  begin
    spVerificadorTelas.RegistrarMensagem(
      'Informe uma forma de pagamento diferente da forma atual.', 'OK');
  end;

  if FoDados.fpgSemInformarMunicipio then
  begin
    spVerificadorTelas.RegistrarMensagem('Informe o município do mandado.', 'OK');
  end;
end;

function TffpgAlteracaoFormaPgtoTests.PegarClasseModelTests: TfpgDataModelTestsClass;
begin
  result := TffpgAlteracaoFormaPgtoModelTests;
end;

procedure TffpgAlteracaoFormaPgtoTests.AlteracaoFormaPgto;
var
  sCDMandado: string;
begin
  AbrirTela;
  FoTela := TffpgAlteracaoFormaPgto(spTela);
  FoDados := (spDataModelTests) as TffpgAlteracaoFormaPgtoModelTests;

  PreencherAlteracaoFormaPgto;

  sCDMandado := FoTela.smdNumeroMandado.smdCodigoObjetoMandado;

  FoTela.ccCadastro.Execute(acSalvar);
  check(FoDados.VerficarAlteracaoFormaPgto(sCDMandado, FoDados.fpgCdFormaPgto),
    'O mandado ' + FoTela.smdNumeroMandado.smdNumeroMandado +
    ' não teve a forma de pagamento alterada');
end;

procedure TffpgAlteracaoFormaPgtoTests.TearDown;
begin
  FecharTela;
  inherited;
end;

end.

