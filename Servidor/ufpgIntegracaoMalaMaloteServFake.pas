unit ufpgIntegracaoMalaMaloteServFake;

interface

uses
  DB, DBClient, ufpgIntegracaoMalaMaloteServ;

type

  TfpgIntegracaoMalaMaloteServFake = class(TfpgIntegracaoMalaMaloteServ)
  private
    function TestarLoginUsuarioExiste(const psUsuario: string): boolean;
    function TestarSenhaWSExiste(const pnIndice: integer; const psSenha: string): boolean;
    function TestarUsuarioWSExiste(const psUsuario: string): boolean;
    function TestarGuiaExiste(const psGuia: string): boolean;
    function PegarIndiceUsuarioWS(const psUsuario: string): integer;

    function ExcluirGuiasTransporteFake(pvPacoteDados: olevariant): olevariant;
    function RetornarAlgumErroPossivelAoExcluirGuia(const cdsDados: TClientDataSet): integer;

    function PegarGuiasFake(pvPacoteDados: olevariant): olevariant;
    function RetornarAlgumErroPossivelAoPegarGuia(const cdsDados: TClientDataSet): integer;
    function DesempacotarParametroEmDataSet(pvParams: olevariant): TClientDataSet;
  protected
    function ExecutarOperacao(const psMetodo: string; pvPacoteDados: olevariant): olevariant;
      override;

  public
    /// <summary>
    ///  Apenas executa método da classe real. Redeclarado nessa classe, como public,
    ///  para se tornar testável sem torná-lo visível na api. Método privado que é crítico mas
    ///  devido a infraestrutura não é possível cercar todas as situações.
    /// </summary>
    /// <param name="pnCdErro">
    ///   Retorno de operação
    /// </param>
    /// <remarks>
    ///  11/10/2013 - Luiz.marques - SALT: 147569/1
    /// </remarks>
    function PegarCodigoErroSistema(const pnCdErro: integer): integer; override;

    /// <summary>
    ///  Apenas executa método da classe real. Redeclarado nessa classe, como public,
    ///  para se tornar testável sem torná-lo visível na api. Método privado que é crítico mas
    ///  devido a infraestrutura não é possível cercar todas as situações.
    /// </summary>
    /// <param name="pvRetOperacao">
    ///   Retorno de operação
    /// </param>
    /// <remarks>
    ///  11/10/2013 - Luiz.marques - SALT: 147569/1
    /// </remarks>
    procedure ValidarRetornoPegarGuias(pvRetOperacao: olevariant); override;
  end;

implementation

uses
  SysUtils, uSajConstante, Classes;

const
  aGuiasGeradasFake: array [0..2] of string =
    ('00000000001201300000043410007000466', '00000000001201300000044250007000466',
    '00000000001201300000043410007000466');

  aUSUARIOS_WS: array [0..1] of string = ('SAJ-WS', 'SOFTPLAN-WS');
  aSENHAS_WS: array [0..1] of string = ('123456', '456789');
  aLOGIN_USUARIOS: array [0..1] of string = ('SAJ', 'SOFTPLAN');

{ TfpgIntegracaoMalaMaloteServFake }

function TfpgIntegracaoMalaMaloteServFake.ExecutarOperacao(const psMetodo: string;
  pvPacoteDados: olevariant): olevariant;
begin
  if psMetodo = 'PEGARGUIASTRANSPORTE' then
    result := PegarGuiasFake(pvPacoteDados);

  if psMetodo = 'EXCLUIRGUIA' then
    result := ExcluirGuiasTransporteFake(pvPacoteDados);
end;

function TfpgIntegracaoMalaMaloteServFake.PegarGuiasFake(pvPacoteDados: olevariant): olevariant;
var
  cdsDados: TClientDataSet;
  nCdErro: integer;
begin
  result := VarArrayCreate([0, 1], varVariant);
  cdsDados := DesempacotarParametroEmDataSet(pvPacoteDados);
  try
    nCdErro := RetornarAlgumErroPossivelAoPegarGuia(cdsDados);


    if nCdErro = NUMERO_INDEFINIDO then
    begin
      result[0] := 'OK';
      exit;
    end;

    result[0] := 'ERRO';
    result[1] := nCdErro;
  finally
    FreeAndNil(cdsDados);//PC_OK
  end;
end;

function TfpgIntegracaoMalaMaloteServFake.DesempacotarParametroEmDataSet(
  pvParams: olevariant): TClientDataSet;
var
  oStrParams: TStringStream;
begin
  result := TClientDataSet.Create(nil); //PC_OK
  try
    oStrParams := TStringStream.Create(pvParams);
    result.loadFromStream(oStrParams);
  finally
    FreeAndNil(oStrParams);
  end;
end;

function TfpgIntegracaoMalaMaloteServFake.ExcluirGuiasTransporteFake(
  pvPacoteDados: olevariant): olevariant;
var
  cdsDados: TClientDataSet;
  nCdErro: integer;
  oStrGuia: TStringStream;
begin
  result := VarArrayCreate([0, 1], varVariant);
  oStrGuia := TStringStream.Create(pvPacoteDados);
  cdsDados := TClientdataset.Create(nil);
  try
    cdsDados.LoadFromStream(oStrGuia);

    nCdErro := RetornarAlgumErroPossivelAoExcluirGuia(cdsDados);

    if nCdErro = NUMERO_INDEFINIDO then
    begin
      result[0] := sTAG_WSMM_RETORNO_OK;
      exit;
    end;

    result[0] := sTAG_WSMM_RETORNO_ERRO;
    result[1] := nCdErro;
  finally
    FreeAndNil(cdsDados);
    FreeAndNil(oStrGuia);
  end;
end;

function TfpgIntegracaoMalaMaloteServFake.RetornarAlgumErroPossivelAoPegarGuia(
  const cdsDados: TClientDataSet): integer;
begin
  result := NUMERO_INDEFINIDO;
  cdsDados.First;

  while not cdsDados.EOF do
  begin
    if not TestarGuiaExiste(cdsDados.FieldByName('NUMALAMALOTE').AsString) then
    begin
      result := nERRO_018_WSMM_GUIA_REFER_COD_BARRA_NAO_ENCONTRADO;
      exit;
    end;

    cdsDados.Next;
  end;
end;

function TfpgIntegracaoMalaMaloteServFake.TestarGuiaExiste(const psGuia: string): boolean;
var
  i: integer;
begin
  result := True;

  for i := 0 to length(aGuiasGeradasFake) do
    if aGuiasGeradasFake[i] = psGuia then
      exit;

  result := False;
end;

function TfpgIntegracaoMalaMaloteServFake.PegarCodigoErroSistema(const pnCdErro: integer): integer;
begin
  result := inherited PegarCodigoErroSistema(pnCdErro);
end;

procedure TfpgIntegracaoMalaMaloteServFake.ValidarRetornoPegarGuias(pvRetOperacao: olevariant);
begin
  inherited ValidarRetornoPegarGuias(pvRetOperacao);
end;

function TfpgIntegracaoMalaMaloteServFake.TestarUsuarioWSExiste(const psUsuario: string): boolean;
begin
  result := False;
  if PegarIndiceUsuarioWS(psUsuario) = NUMERO_INDEFINIDO then
    exit;

  result := True;
end;

function TfpgIntegracaoMalaMaloteServFake.RetornarAlgumErroPossivelAoExcluirGuia(
  const cdsDados: TClientDataSet): integer;
var
  oLista: TStrings;
  I: integer;
begin
  result := NUMERO_INDEFINIDO;
  oLista := TStringList.Create;
  try
    cdsDados.First;
    while not cdsDados.EOF do
    begin

      oLista.Clear;
      oLista.CommaText := StringReplace(cdsDados.FieldByName('BLGUIAS').AsString,
        ';', ',', [rfReplaceAll]);
      for I := 0 to oLista.Count - 1 do
      begin
        if not TestarGuiaExiste(oLista.Strings[I]) then
        begin
          result := nERRO_018_WSMM_GUIA_REFER_COD_BARRA_NAO_ENCONTRADO;
          exit;
        end;
      end;

      if not TestarLoginUsuarioExiste(cdsDados.FieldByName('CDUSUARIO').AsString) then
      begin
        result := nERRO_022_WSMM_LOGIN_USUARIO_NAO_ENCONTRADO;
        exit;
      end;

      if not TestarUsuarioWSExiste(Self.fpgDadosServidor.fpgLoginWs) then
      begin
        result := nERRO_101_WSMM_USUARIO_NAO_ENCONTRADO_OU_SENHA_INVALIDA;
        exit;
      end;

      if not TestarSenhaWSExiste(PegarIndiceUsuarioWS(Self.fpgDadosServidor.fpgLoginWs),
        Self.fpgDadosServidor.fpgSenhaws) then
      begin
        result := nERRO_101_WSMM_USUARIO_NAO_ENCONTRADO_OU_SENHA_INVALIDA;
        exit;
      end;

      cdsDados.Next;
    end;

  finally
    FreeAndNil(oLista);
  end;
end;

function TfpgIntegracaoMalaMaloteServFake.TestarLoginUsuarioExiste(
  const psUsuario: string): boolean;
var
  I: integer;
begin
  result := True;
  for I := 0 to length(aLOGIN_USUARIOS) do
    if aLOGIN_USUARIOS[I] = psUsuario then
      exit;
  result := False;
end;

function TfpgIntegracaoMalaMaloteServFake.PegarIndiceUsuarioWS(const psUsuario: string): integer;
var
  I: integer;
begin
  result := NUMERO_INDEFINIDO;

  for I := 0 to length(aUSUARIOS_WS) do
  begin
    if aUSUARIOS_WS[I] = psUsuario then
    begin
      result := I;
      break;
    end;
  end;
end;

function TfpgIntegracaoMalaMaloteServFake.TestarSenhaWSExiste(const pnIndice: integer;
  const psSenha: string): boolean;
begin
  result := (aSENHAS_WS[pnIndice] = psSenha);
end;

end.

