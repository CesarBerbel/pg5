unit ufpgProcessoBemListModelTests;

interface

uses
  uspDataModelTests;

type
  TfpgProcessoBemListModelTests = class(TspDataModelTests)
  private
    FsCodigoProcesso: string;
    FsNumeroProcesso: string;
    FbPossuiBemNaoBaixado: boolean;
    FnPosicaoLista: integer;
    /// <summary>
    ///  Retorna o c�digo do processo
    /// </summary>
    /// <returns>
    ///  string
    /// </returns>
    /// <remarks>
    ///  Remarks
    ///  28/08/2014 - rodrigo.db1 - SALT: 109652/1
    /// </remarks>
    function GetfpgCodigoProcesso: string;
    /// <summary>
    ///  Retorna o n�mero do processo
    /// </summary>
    /// <returns>
    ///  string
    /// </returns>
    /// <remarks>
    ///  Remarks
    ///  28/08/2014 - rodrigo.db1 - SALT: 109652/1
    /// </remarks>
    function GetfpgNumeroProcesso: string;
    /// <summary>
    ///  Retorna se o processo possui bem n�o baixado
    /// </summary>
    /// <returns>
    ///  boolean
    /// </returns>
    /// <remarks>
    ///  Remarks
    ///  28/08/2014 - rodrigo.db1 - SALT: 109652/1
    /// </remarks>
    function GetfpgPossuiBemNaoBaixado: boolean;
    /// <summary>
    ///  Retorna a posi��o na lista
    /// </summary>
    /// <returns>
    ///  integer
    /// </returns>
    /// <remarks>
    ///  Remarks
    ///  28/08/2014 - rodrigo.db1 - SALT: 109652/1
    /// </remarks>
    function GetfpgPosicaoLista: integer;
    /// <summary>
    ///  Define o c�digo do processo
    /// </summary>
    /// <param name="Value">
    /// </param>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    ///  Remarks
    ///  28/08/2014 - rodrigo.db1 - SALT: 109652/1
    /// </remarks>
    procedure SetfpgCodigoProcesso(const Value: string);
    /// <summary>
    ///  Define o n�mero do processo
    /// </summary>
    /// <param name="Value">
    /// </param>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    ///  Remarks
    ///  28/08/2014 - rodrigo.db1 - SALT: 109652/1
    /// </remarks>
    procedure SetfpgNumeroProcesso(const Value: string);
    /// <summary>
    ///  Define se o processo possui bem n�o baixado
    /// </summary>
    /// <param name="Value">
    /// </param>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    ///  Remarks
    ///  28/08/2014 - rodrigo.db1 - SALT: 109652/1
    /// </remarks>
    procedure SetfpgPossuiBemNaoBaixado(const Value: boolean);
    /// <summary>
    ///  Define a posi��o na lista
    /// </summary>
    /// <param name="Value">
    /// </param>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    ///  Remarks
    ///  28/08/2014 - rodrigo.db1 - SALT: 109652/1
    /// </remarks>
    procedure SetfpgPosicaoLista(const Value: integer);
  published
    /// <summary>
    ///  C�digo do processo
    /// </summary>
    /// <value>
    ///  Value
    /// </value>
    /// <remarks>
    ///  Remarks
    ///  28/08/2014 - rodrigo.db1 - SALT: 109652/1
    /// </remarks>
    property fpgCodigoProcesso: string read GetfpgCodigoProcesso write SetfpgCodigoProcesso;
    /// <summary>
    ///  N�mero do processo
    /// </summary>
    /// <value>
    ///  Value
    /// </value>
    /// <remarks>
    ///  Remarks
    ///  28/08/2014 - rodrigo.db1 - SALT: 109652/1
    /// </remarks>
    property fpgNumeroProcesso: string read GetfpgNumeroProcesso write SetfpgNumeroProcesso;
    /// <summary>
    ///  Processo possui bem n�o baixado
    /// </summary>
    /// <value>
    ///  Value
    /// </value>
    /// <remarks>
    ///  Remarks
    ///  28/08/2014 - rodrigo.db1 - SALT: 109652/1
    /// </remarks>
    property fpgPossuiBemNaoBaixado: boolean read GetfpgPossuiBemNaoBaixado   
      write SetfpgPossuiBemNaoBaixado;
    /// <summary>
    ///  Posi��o do item na lista
    /// </summary>
    /// <value>
    ///  Value
    /// </value>
    /// <remarks>
    ///  Remarks
    ///  28/08/2014 - rodrigo.db1 - SALT: 109652/1
    /// </remarks>
    property fpgPosicaoLista: integer read GetfpgPosicaoLista write SetfpgPosicaoLista;
  end;

implementation

{ TfpgProcessoBemListModelTests }

// 28/08/2014 - rodrigo.db1 - SALT: 109652/1
function TfpgProcessoBemListModelTests.GetfpgCodigoProcesso: string;
begin
  result := FsCodigoProcesso;
end;

// 28/08/2014 - rodrigo.db1 - SALT: 109652/1
function TfpgProcessoBemListModelTests.GetfpgNumeroProcesso: string;
begin
  result := FsNumeroProcesso;
end;

// 28/08/2014 - rodrigo.db1 - SALT: 109652/1
function TfpgProcessoBemListModelTests.GetfpgPossuiBemNaoBaixado: boolean;
begin
  result := FbPossuiBemNaoBaixado;
end;

// 28/08/2014 - rodrigo.db1 - SALT: 109652/1
function TfpgProcessoBemListModelTests.GetfpgPosicaoLista: integer;
begin
  result := FnPosicaoLista;
end;

// 28/08/2014 - rodrigo.db1 - SALT: 109652/1
procedure TfpgProcessoBemListModelTests.SetfpgCodigoProcesso(const Value: string);
begin
  FsCodigoProcesso := Value;
end;

// 28/08/2014 - rodrigo.db1 - SALT: 109652/1
procedure TfpgProcessoBemListModelTests.SetfpgNumeroProcesso(const Value: string);
begin
  FsNumeroProcesso := Value;
end;

// 28/08/2014 - rodrigo.db1 - SALT: 109652/1
procedure TfpgProcessoBemListModelTests.SetfpgPossuiBemNaoBaixado(const Value: boolean);
begin
  FbPossuiBemNaoBaixado := Value;
end;

// 28/08/2014 - rodrigo.db1 - SALT: 109652/1
procedure TfpgProcessoBemListModelTests.SetfpgPosicaoLista(const Value: integer);
begin
  FnPosicaoLista := Value;
end;

end.

