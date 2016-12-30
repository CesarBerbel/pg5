unit ufpgCtrlProcessoParteTests;

{*****************************************************************************
Projeto/Sistema: PG5 / Componentes
Objetivo: Implementar a classe de testes unit�rios da classe TfpgCtrlProcessoParte
Cria��o: 22/11/2014 - rodrigo.db1
*****************************************************************************}

interface

uses
  SysUtils, uspTestCase, ufpgCtrlProcessoParteFake, ufpgCtrlProcessoParteModelTests;

type
  TfpgCtrlProcessoParteTests = class(TspTestCase)
  private
    FoControle: TfpgCtrlProcessoParteFake;
    /// <summary>
    ///  Executa o roteiro de testes do m�todo PegarPermissaoInclusao
    /// </summary>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    ///  Remarks
    ///  28/11/2014 - rodrigo.db1 - SALT: 152429/1
    /// </remarks>
    procedure ExecutarTestePegarPermissaoInclusao;
    /// <summary>
    ///  Executa o roteiro de testes do m�todo PegarPermissaoAlteracao
    /// </summary>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    ///  Remarks
    ///  28/11/2014 - rodrigo.db1 - SALT: 152429/1
    /// </remarks>
    procedure ExecutarTestePegarPermissaoAlteracao;
    /// <summary>
    ///  Executa o roteiro de testes do m�todo PegarPermissaoAlteracaoNome
    /// </summary>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    ///  Remarks
    ///  28/11/2014 - rodrigo.db1 - SALT: 152429/1
    /// </remarks>
    procedure ExecutarTestePegarPermissaoAlteracaoNome;
    /// <summary>
    ///  Executa o roteiro de testes do m�todo PegarPermissaoExclusao
    /// </summary>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    ///  Remarks
    ///  28/11/2014 - rodrigo.db1 - SALT: 152429/1
    /// </remarks>
    procedure ExecutarTestePegarPermissaoExclusao;
    /// <summary>
    ///  Executa o roteiro de testes do m�todo PegarPermissaoExclusaoParteComMandado
    /// </summary>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    ///  Remarks
    ///  28/11/2014 - rodrigo.db1 - SALT: 152429/1
    /// </remarks>
    procedure ExecutarTestePegarPermissaoExclusaoParteComMandado;
  protected
    /// <summary>
    ///  Cria os objetos necess�rios para o teste
    /// </summary>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    ///  Remarks
    ///  28/11/2014 - rodrigo.db1 - SALT: 152429/1
    /// </remarks>
    procedure SetUp; override;
    /// <summary>
    ///  Destr�i os objetos utilizados no teste
    /// </summary>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    ///  Remarks
    ///  28/11/2014 - rodrigo.db1 - SALT: 152429/1
    /// </remarks>
    procedure TearDown; override;
  published
    /// <summary>
    ///  Testa o m�todo PegarPermissaoInclusao
    /// </summary>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    ///  Remarks
    ///  28/11/2014 - rodrigo.db1 - SALT: 152429/1
    /// </remarks>
    procedure TestarPegarPermissaoInclusao;
    /// <summary>
    ///  Testa o m�todo PegarPermissaoAlteracao
    /// </summary>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    ///  Remarks
    ///  28/11/2014 - rodrigo.db1 - SALT: 152429/1
    /// </remarks>
    procedure TestarPegarPermissaoAlteracao;
    /// <summary>
    ///  Testa o m�todo PegarPermissaoAlteracaoNome
    /// </summary>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    ///  Remarks
    ///  28/11/2014 - rodrigo.db1 - SALT: 152429/1
    /// </remarks>
    procedure TestarPegarPermissaoAlteracaoNome;
    /// <summary>
    ///  Testa o m�todo PegarPermissaoExclusao
    /// </summary>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    ///  Remarks
    ///  28/11/2014 - rodrigo.db1 - SALT: 152429/1
    /// </remarks>
    procedure TestarPegarPermissaoExclusao;
    /// <summary>
    ///  Testa o m�todo PegarPermissaoExclusaoParteComMandado
    /// </summary>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    ///  Remarks
    ///  28/11/2014 - rodrigo.db1 - SALT: 152429/1
    /// </remarks>
    procedure TestarPegarPermissaoExclusaoParteComMandado;
  end;

implementation

const
  sNOME_SUITE = 'Unit�rio\PG5\Componentes\pg5Componentes\ufpgCtrlProcessoParteTests';
  sABA_PRINCIPAL = 'DadosPrincipal';

{ TfpgCtrlProcessoParteTests }

// 28/11/2014 - rodrigo.db1 - SALT: 152429/1
procedure TfpgCtrlProcessoParteTests.ExecutarTestePegarPermissaoInclusao;
var
  oModel: TfpgCtrlProcessoParteModelTests;
  bAutorizado: boolean;
begin
  oModel := TfpgCtrlProcessoParteModelTests(FoModelTests);

  FoControle.fpgIDTeste := oModel.spIDTeste;
  FoControle.fpgFormPai := oModel.fpgFormPai;
  FoControle.fpgProcessoDistribuido := oModel.fpgProcessoDistribuido;
  FoControle.CarregarDados;
  bAutorizado := FoControle.PegarPermissaoInclusao(oModel.fpgTipoParte);

  CheckEquals(oModel.fpgResultado, bAutorizado, oModel.fpgMensagemErro);
end;

// 28/11/2014 - rodrigo.db1 - SALT: 152429/1
procedure TfpgCtrlProcessoParteTests.ExecutarTestePegarPermissaoAlteracao;
var
  oModel: TfpgCtrlProcessoParteModelTests;
  bAutorizado: boolean;
begin
  oModel := TfpgCtrlProcessoParteModelTests(FoModelTests);

  FoControle.fpgIDTeste := oModel.spIDTeste;
  FoControle.fpgFormPai := oModel.fpgFormPai;
  FoControle.fpgProcessoDistribuido := oModel.fpgProcessoDistribuido;
  FoControle.CarregarDados;
  bAutorizado := FoControle.PegarPermissaoAlteracao(oModel.fpgTipoParte);

  CheckEquals(oModel.fpgResultado, bAutorizado, oModel.fpgMensagemErro);
end;

// 28/11/2014 - rodrigo.db1 - SALT: 152429/1
procedure TfpgCtrlProcessoParteTests.ExecutarTestePegarPermissaoAlteracaoNome;
var
  oModel: TfpgCtrlProcessoParteModelTests;
  bAutorizado: boolean;
begin
  oModel := TfpgCtrlProcessoParteModelTests(FoModelTests);

  FoControle.fpgIDTeste := oModel.spIDTeste;
  FoControle.fpgFormPai := oModel.fpgFormPai;
  FoControle.fpgProcessoDistribuido := oModel.fpgProcessoDistribuido;
  FoControle.CarregarDados;
  bAutorizado := FoControle.PegarPermissaoAlteracaoNome(oModel.fpgTipoParte);

  CheckEquals(oModel.fpgResultado, bAutorizado, oModel.fpgMensagemErro);
end;

// 28/11/2014 - rodrigo.db1 - SALT: 152429/1
procedure TfpgCtrlProcessoParteTests.ExecutarTestePegarPermissaoExclusao;
var
  oModel: TfpgCtrlProcessoParteModelTests;
  bAutorizado: boolean;
begin
  oModel := TfpgCtrlProcessoParteModelTests(FoModelTests);

  FoControle.fpgIDTeste := oModel.spIDTeste;
  FoControle.fpgFormPai := oModel.fpgFormPai;
  FoControle.fpgProcessoDistribuido := oModel.fpgProcessoDistribuido;
  FoControle.CarregarDados;
  bAutorizado := FoControle.PegarPermissaoExclusao(oModel.fpgTipoParte);

  CheckEquals(oModel.fpgResultado, bAutorizado, oModel.fpgMensagemErro);
end;

// 28/11/2014 - rodrigo.db1 - SALT: 152429/1
procedure TfpgCtrlProcessoParteTests.ExecutarTestePegarPermissaoExclusaoParteComMandado;
var
  oModel: TfpgCtrlProcessoParteModelTests;
  bAutorizado: boolean;
begin
  oModel := TfpgCtrlProcessoParteModelTests(FoModelTests);

  FoControle.fpgIDTeste := oModel.spIDTeste;
  FoControle.CarregarDados;
  bAutorizado := FoControle.PegarPermissaoExclusaoParteComMandado(oModel.fpgMandadoCumprido);

  CheckEquals(oModel.fpgResultado, bAutorizado, oModel.fpgMensagemErro);
end;

// 28/11/2014 - rodrigo.db1 - SALT: 152429/1
procedure TfpgCtrlProcessoParteTests.SetUp;
begin
  spCarregarDadosSetup := False;
  inherited;
  FoControle := TfpgCtrlProcessoParteFake.Create; //PC_OK
end;

// 28/11/2014 - rodrigo.db1 - SALT: 152429/1
procedure TfpgCtrlProcessoParteTests.TearDown;
begin
  inherited;
  if Assigned(FoControle) then
  begin
    FreeAndNil(FoControle); //PC_OK
  end;
end;

// 28/11/2014 - rodrigo.db1 - SALT: 152429/1
procedure TfpgCtrlProcessoParteTests.TestarPegarPermissaoInclusao;
begin
  ExecutarRoteiroTestes(ExecutarTestePegarPermissaoInclusao);
end;

// 28/11/2014 - rodrigo.db1 - SALT: 152429/1
procedure TfpgCtrlProcessoParteTests.TestarPegarPermissaoAlteracao;
begin
  ExecutarRoteiroTestes(ExecutarTestePegarPermissaoAlteracao);
end;

// 28/11/2014 - rodrigo.db1 - SALT: 152429/1
procedure TfpgCtrlProcessoParteTests.TestarPegarPermissaoAlteracaoNome;
begin
  ExecutarRoteiroTestes(ExecutarTestePegarPermissaoAlteracaoNome);
end;

// 28/11/2014 - rodrigo.db1 - SALT: 152429/1
procedure TfpgCtrlProcessoParteTests.TestarPegarPermissaoExclusao;
begin
  ExecutarRoteiroTestes(ExecutarTestePegarPermissaoExclusao);
end;

// 28/11/2014 - rodrigo.db1 - SALT: 152429/1
procedure TfpgCtrlProcessoParteTests.TestarPegarPermissaoExclusaoParteComMandado;
begin
  ExecutarRoteiroTestes(ExecutarTestePegarPermissaoExclusaoParteComMandado);
end;

initialization
  TspTestCase.RegisterTestXLS(sNOME_SUITE, TfpgCtrlProcessoParteTests, sABA_PRINCIPAL,
    TfpgCtrlProcessoParteModelTests);

end.

