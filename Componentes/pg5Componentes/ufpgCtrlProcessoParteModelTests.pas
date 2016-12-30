unit ufpgCtrlProcessoParteModelTests;

{*****************************************************************************
Projeto/Sistema: PG5 / Componentes
Objetivo: Implementar a classe model para testes unitários da classe TfpgCtrlProcessoParte
Criação: 22/11/2014 - rodrigo.db1
*****************************************************************************}

interface

uses
  uspDataModelTests;

type
  TfpgCtrlProcessoParteModelTests = class(TspDataModelTests)
  private
    FnTipoParte: integer;
    FsFormPai: string;
    FbProcessoDistribuido: boolean;
    FbMandadoCumprido: boolean;
    FbResultado: boolean;
    FsMensagemErro: string;
    /// <summary>
    ///  Retorna a variável FnTipoParte
    /// </summary>
    /// <returns>
    ///  integer
    /// </returns>
    /// <remarks>
    ///  Remarks
    ///  28/11/2014 - rodrigo.db1 - SALT: 152429/1
    /// </remarks>
    function GetfpgTipoParte: integer;
    /// <summary>
    ///  Retorna a variável FsFormPai
    /// </summary>
    /// <returns>
    ///  string
    /// </returns>
    /// <remarks>
    ///  Remarks
    ///  28/11/2014 - rodrigo.db1 - SALT: 152429/1
    /// </remarks>
    function GetfpgFormPai: string;
    /// <summary>
    ///  Retorna a variável FbProcessoDistribuido
    /// </summary>
    /// <returns>
    ///  boolean
    /// </returns>
    /// <remarks>
    ///  Remarks
    ///  28/11/2014 - rodrigo.db1 - SALT: 152429/1
    /// </remarks>
    function GetfpgProcessoDistribuido: boolean;
    /// <summary>
    ///  Retorna a variável FbMandadoCumprido
    /// </summary>
    /// <returns>
    ///  boolean
    /// </returns>
    /// <remarks>
    ///  Remarks
    ///  28/11/2014 - rodrigo.db1 - SALT: 152429/1
    /// </remarks>
    function GetfpgMandadoCumprido: boolean;
    /// <summary>
    ///  Retorna a variável FsResultado
    /// </summary>
    /// <returns>
    ///  boolean
    /// </returns>
    /// <remarks>
    ///  Remarks
    ///  28/11/2014 - rodrigo.db1 - SALT: 152429/1
    /// </remarks>
    function GetfpgResultado: boolean;
    /// <summary>
    ///  Retorna a variável FsMensagemErro
    /// </summary>
    /// <returns>
    ///  string
    /// </returns>
    /// <remarks>
    ///  Remarks
    ///  28/11/2014 - rodrigo.db1 - SALT: 152429/1
    /// </remarks>
    function GetfpgMensagemErro: string;
    /// <summary>
    ///  Define valor para a variável FnTipoParte
    /// </summary>
    /// <param name="Value">
    /// </param>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    ///  Remarks
    ///  28/11/2014 - rodrigo.db1 - SALT: 152429/1
    /// </remarks>
    procedure SetfpgTipoParte(const Value: integer);
    /// <summary>
    ///  Define valor para a variável FsFormPai
    /// </summary>
    /// <param name="Value">
    /// </param>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    ///  Remarks
    ///  28/11/2014 - rodrigo.db1 - SALT: 152429/1
    /// </remarks>
    procedure SetfpgFormPai(const Value: string);
    /// <summary>
    ///  Define valor para a variável FbProcessoDistribuido
    /// </summary>
    /// <param name="Value">
    /// </param>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    ///  Remarks
    ///  28/11/2014 - rodrigo.db1 - SALT: 152429/1
    /// </remarks>
    procedure SetfpgProcessoDistribuido(const Value: boolean);
    /// <summary>
    ///  Define valor para a variável FbMandadoCumprido
    /// </summary>
    /// <param name="Value">
    /// </param>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    ///  Remarks
    ///  28/11/2014 - rodrigo.db1 - SALT: 152429/1
    /// </remarks>
    procedure SetfpgMandadoCumprido(const Value: boolean);
    /// <summary>
    ///  Define valor para a variável FsResultado
    /// </summary>
    /// <param name="Value">
    /// </param>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    ///  Remarks
    ///  28/11/2014 - rodrigo.db1 - SALT: 152429/1
    /// </remarks>
    procedure SetfpgResultado(const Value: boolean);
    /// <summary>
    ///  Define valor para a variável FsMensagemErro
    /// </summary>
    /// <param name="Value">
    /// </param>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    ///  Remarks
    ///  28/11/2014 - rodrigo.db1 - SALT: 152429/1
    /// </remarks>
    procedure SetfpgMensagemErro(const Value: string);
  published
    /// <summary>
    ///  Tipo da parte
    /// </summary>
    /// <value>
    ///  Value
    /// </value>
    /// <remarks>
    ///  Remarks
    ///  28/11/2014 - rodrigo.db1 - SALT: 152429/1
    /// </remarks>
    property fpgTipoParte: integer read GetfpgTipoParte write SetfpgTipoParte;
    /// <summary>
    ///  Nome do formulário pai
    /// </summary>
    /// <value>
    ///  Value
    /// </value>
    /// <remarks>
    ///  Remarks
    ///  28/11/2014 - rodrigo.db1 - SALT: 152429/1
    /// </remarks>
    property fpgFormPai: string read GetfpgFormPai write SetfpgFormPai;
    /// <summary>
    ///  Processo distribuído
    /// </summary>
    /// <value>
    ///  Value
    /// </value>
    /// <remarks>
    ///  Remarks
    ///  28/11/2014 - rodrigo.db1 - SALT: 152429/1
    /// </remarks>
    property fpgProcessoDistribuido: boolean read GetfpgProcessoDistribuido   
      write SetfpgProcessoDistribuido;
    /// <summary>
    ///  Mandado cumprido
    /// </summary>
    /// <returns>
    ///  integer
    /// </returns>
    /// <remarks>
    ///  Remarks
    ///  28/11/2014 - rodrigo.db1 - SALT: 152429/1
    /// </remarks>
    property fpgMandadoCumprido: boolean read GetfpgMandadoCumprido write SetfpgMandadoCumprido;
    /// <summary>
    ///  Resultado esperado para o teste
    /// </summary>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    ///  Remarks
    ///  28/11/2014 - rodrigo.db1 - SALT: 152429/1
    /// </remarks>
    property fpgResultado: boolean read GetfpgResultado write SetfpgResultado;
    /// <summary>
    ///  Mensagem de erro do teste
    /// </summary>
    /// <returns>
    ///  None
    /// </returns>
    ///  None
    /// <remarks>
    ///  Remarks
    ///  28/11/2014 - rodrigo.db1 - SALT: 152429/1
    /// </remarks>
    property fpgMensagemErro: string read GetfpgMensagemErro write SetfpgMensagemErro;
  end;

implementation

{ TfpgCtrlProcessoParteModelTests }

// 28/11/2014 - rodrigo.db1 - SALT: 152429/1
function TfpgCtrlProcessoParteModelTests.GetfpgTipoParte: integer;
begin
  result := FnTipoParte;
end;

// 28/11/2014 - rodrigo.db1 - SALT: 152429/1
function TfpgCtrlProcessoParteModelTests.GetfpgFormPai: string;
begin
  result := FsFormPai;
end;

// 28/11/2014 - rodrigo.db1 - SALT: 152429/1
function TfpgCtrlProcessoParteModelTests.GetfpgProcessoDistribuido: boolean;
begin
  result := FbProcessoDistribuido;
end;

// 28/11/2014 - rodrigo.db1 - SALT: 152429/1
function TfpgCtrlProcessoParteModelTests.GetfpgResultado: boolean;
begin
  result := FbResultado;
end;

// 28/11/2014 - rodrigo.db1 - SALT: 152429/1
function TfpgCtrlProcessoParteModelTests.GetfpgMensagemErro: string;
begin
  result := FsMensagemErro;
end;

// 28/11/2014 - rodrigo.db1 - SALT: 152429/1
procedure TfpgCtrlProcessoParteModelTests.SetfpgTipoParte(const Value: integer);
begin
  FnTipoParte := Value;
end;

// 28/11/2014 - rodrigo.db1 - SALT: 152429/1
procedure TfpgCtrlProcessoParteModelTests.SetfpgFormPai(const Value: string);
begin
  FsFormPai := Value;
end;

// 28/11/2014 - rodrigo.db1 - SALT: 152429/1
procedure TfpgCtrlProcessoParteModelTests.SetfpgProcessoDistribuido(const Value: boolean);
begin
  FbProcessoDistribuido := Value;
end;

// 28/11/2014 - rodrigo.db1 - SALT: 152429/1
function TfpgCtrlProcessoParteModelTests.GetfpgMandadoCumprido: boolean;
begin
  result := FbMandadoCumprido;
end;

// 28/11/2014 - rodrigo.db1 - SALT: 152429/1
procedure TfpgCtrlProcessoParteModelTests.SetfpgMandadoCumprido(const Value: boolean);
begin
  FbMandadoCumprido := Value;
end;

// 28/11/2014 - rodrigo.db1 - SALT: 152429/1
procedure TfpgCtrlProcessoParteModelTests.SetfpgResultado(const Value: boolean);
begin
  FbResultado := Value;
end;

// 28/11/2014 - rodrigo.db1 - SALT: 152429/1
procedure TfpgCtrlProcessoParteModelTests.SetfpgMensagemErro(const Value: string);
begin
  FsMensagemErro := Value;
end;

end.

