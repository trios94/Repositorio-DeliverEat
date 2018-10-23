<%@ Page Title="Pago Pedido No Realizado" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ConfirmacionLoQueSea.aspx.cs" Inherits="DeliverEat.ConfirmacionLoQueSea" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <div class="py-5 text-center">
            <h2>Pedido Lo Que Sea - Paso 2</h2>
        </div>

        <div class="row">
            <div class="col-md-4 order-md-2 mb-4">
                <h4 class="d-flex justify-content-between align-items-center mb-3">
                    <span class="text-muted">Su pedido N° <%= p.IdPedido %></span>
                </h4>
                <asp:TextBox runat="server" ID="txtPedido" CssClass="form-control" ReadOnly="true" TextMode="MultiLine" cols="40" Rows="8"></asp:TextBox>
                <form class="card p-2">
                    <label for="txtCostoPedido">Costo Aproximado</label>
                    <div class="input-group">
                        <div class="input-group-prepend">
                            <span class="input-group-text">$</span>
                        </div>
                        <asp:TextBox runat="server" ID="txtCostoPedido" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                    </div>
                    <label for="txtComisión">Comisión</label>
                    <div class="input-group">
                        <div class="input-group-prepend">
                            <span class="input-group-text">$</span>
                        </div>
                        <asp:TextBox runat="server" ID="txtComisión" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                    </div>
                    <label for="txtVuelto">Vuelto</label>
                    <div class="input-group">
                        <div class="input-group-prepend">
                            <span class="input-group-text">$</span>
                        </div>
                        <asp:TextBox runat="server" ID="txtVuelto" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                    </div>
                </form>
            </div>
            <div class="col-md-8 order-md-1">
                <h4 class="mb-3">Tipo de Envío</h4>
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <div class="mb-3">
                            <asp:DropDownList ID="ddlTipoEnvio" runat="server" CssClass="form-control col-md-4" OnSelectedIndexChanged="ddlTipoEntrega_SelectedIndexChanged" AutoPostBack="True">
                                <asp:ListItem Value="1">Envío Normal</asp:ListItem>
                                <asp:ListItem Value="2">Envío Prioritario</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div id="EnvioNormal" class="row">
                            <div class="col-md-4 mb-3">
                                <label for="txtFechaRecepcion">Fecha Recepción</label>
                                <asp:TextBox runat="server" ID="txtFechaRecepcion" CssClass="form-control" placeholder="dd/mm/aaaa" TextMode="Date"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" CssClass="text-left" ControlToValidate="txtCalle" ErrorMessage="RequiredFieldValidator" Font-Size="X-Small" SetFocusOnError="True"
                                    ForeColor="Red" ValidationGroup="Verificar" Display="Dynamic">Campo obligatorio</asp:RequiredFieldValidator>
                            </div>
                            <div class="col-md-3 mb-3">
                                <label for="txtHoraRecepcion">Hora Recepción</label>
                                <asp:TextBox runat="server" ID="txtHoraRecepcion" CssClass="form-control" placeholder="" TextMode="Time"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" CssClass="text-left" ControlToValidate="txtCalle" ErrorMessage="RequiredFieldValidator" Font-Size="X-Small" SetFocusOnError="True"
                                    ForeColor="Red" ValidationGroup="Verificar" Display="Dynamic">Campo obligatorio</asp:RequiredFieldValidator>
                            </div>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
                <h4 class="mb-3">Dirección de Entrega</h4>
                <div class="row">
                    <div class="col-md-8 mb-3">
                        <label for="txtCalle">Calle</label>
                        <asp:TextBox runat="server" ID="txtCalle" CssClass="form-control" placeholder="" required=""></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" CssClass="text-left" ControlToValidate="txtCalle" ErrorMessage="RequiredFieldValidator" Font-Size="X-Small" SetFocusOnError="True"
                            ForeColor="Red" ValidationGroup="Verificar" Display="Dynamic">Campo obligatorio</asp:RequiredFieldValidator>
                    </div>
                    <div class="col-md-3 mb-3">
                        <label for="txtNumero">Número</label>
                        <asp:TextBox runat="server" ID="txtNumero" CssClass="form-control" placeholder="" required="" TextMode="Number" onKeyUp="return limitar(event,this.value,4)" onKeyDown="return limitar(event,this.value,4)"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" CssClass="text-left" ControlToValidate="txtNumero" ErrorMessage="RequiredFieldValidator" Font-Size="X-Small" SetFocusOnError="True"
                            ForeColor="Red" ValidationGroup="Verificar" Display="Dynamic">Campo obligatorio</asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="mb-3">
                    <label for="txtCodPostal">Código Postal</label>
                    <asp:TextBox runat="server" ID="txtCodPostal" CssClass="form-control col-md-3" placeholder="" required="" TextMode="Number" onKeyUp="return limitar(event,this.value,5)" onKeyDown="return limitar(event,this.value,5)"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" CssClass="text-left" ControlToValidate="txtCodPostal" ErrorMessage="RequiredFieldValidator" Font-Size="X-Small" SetFocusOnError="True"
                        ForeColor="Red" ValidationGroup="Verificar" Display="Dynamic">Campo obligatorio</asp:RequiredFieldValidator>
                </div>
                <div class="row">
                    <div class="col-md-3 mb-3">
                        <label for="txtPiso">Piso</label>
                        <asp:TextBox runat="server" ID="txtPiso" CssClass="form-control" placeholder="" TextMode="Number" onKeyUp="return limitar(event,this.value,2)" onKeyDown="return limitar(event,this.value,2)"></asp:TextBox>
                    </div>
                    <div class="col-md-3 mb-3">
                        <label for="departamento">Departamento</label>
                        <asp:TextBox runat="server" ID="txtDepartamento" CssClass="form-control" placeholder=""></asp:TextBox>
                    </div>
                </div>
                <hr class="mb-4">
                <h4 class="mb-3">Pago</h4>
                <div class="d-block my-3">
                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                        <ContentTemplate>
                            <div class="mb-3">
                                <asp:DropDownList ID="ddlFormaPago" runat="server" CssClass="form-control col-md-5" AutoPostBack="True" OnSelectedIndexChanged="ddlFormaPago_SelectedIndexChanged">
                                    <asp:ListItem Value="1">Tarjeta de crédito (solo VISA)</asp:ListItem>
                                    <asp:ListItem Value="2">Efectivo</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="row col-md-10" id="pagoTarjeta">
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label for="txtTitularTarjeta">Nombre del titular</label>
                                        <asp:TextBox runat="server" ID="txtTitularTarjeta" CssClass="form-control" placeholder=""></asp:TextBox>
                                        <small class="text-muted">Nombre completo como figura en la tarjeta</small>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" CssClass="text-left" ControlToValidate="txtTitularTarjeta" ErrorMessage="RequiredFieldValidator" Font-Size="X-Small" SetFocusOnError="True"
                                            ForeColor="Red" ValidationGroup="Verificar" Display="Dynamic">Campo obligatorio</asp:RequiredFieldValidator>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label for="txtNumeroTarjeta">Número de la tarjeta</label>
                                        <asp:TextBox runat="server" ID="txtNumeroTarjeta" CssClass="form-control" placeholder="" TextMode="Number" onKeyUp="return limitar(event,this.value,16)" onKeyDown="return limitar(event,this.value,16)"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" CssClass="text-left" ControlToValidate="txtNumeroTarjeta" ErrorMessage="RequiredFieldValidator" Font-Size="X-Small" SetFocusOnError="True"
                                            ForeColor="Red" ValidationGroup="Verificar" Display="Dynamic">Campo obligatorio</asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="RegularExpressionValidator" ControlToValidate="txtNumeroTarjeta" Font-Size="X-Small" SetFocusOnError="True"
                                            ForeColor="Red" ValidationGroup="Verificar" Display="Dynamic" ValidationExpression="^4[0-9]{12}(?:[0-9]{3})?$">
                                            Ingrese un número correspondiente a tarjeta VISA
                                        </asp:RegularExpressionValidator>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-4 mb-3">
                                        <label for="txtVencimientoTarjeta">Vencimiento</label>
                                        <asp:TextBox runat="server" ID="txtVencimientoTarjeta" CssClass="form-control" placeholder="mm/aa"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" CssClass="text-left" ControlToValidate="txtVencimientoTarjeta" ErrorMessage="RequiredFieldValidator" Font-Size="X-Small" SetFocusOnError="True"
                                            ForeColor="Red" ValidationGroup="Verificar" Display="Dynamic">Campo obligatorio</asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="RegularExpressionValidator" ControlToValidate="txtVencimientoTarjeta" Font-Size="X-Small" SetFocusOnError="True"
                                            ForeColor="Red" ValidationGroup="Verificar" Display="Dynamic" ValidationExpression="(0[1-9]|10|11|12)/1[0-9]{1}$">
                                            Formato de fecha de vencimiento inválido
                                        </asp:RegularExpressionValidator>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label for="txtCodSeguridadTarjeta">Código de seguridad</label>
                                        <asp:TextBox runat="server" ID="txtCodSeguridadTarjeta" CssClass="form-control" placeholder="xxx" TextMode="Number" onKeyUp="return limitar(event,this.value,3)" onKeyDown="return limitar(event,this.value,3)"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" CssClass="text-left" ControlToValidate="txtCodSeguridadTarjeta" ErrorMessage="RequiredFieldValidator" Font-Size="X-Small" SetFocusOnError="True"
                                            ForeColor="Red" ValidationGroup="Verificar" Display="Dynamic">Campo obligatorio</asp:RequiredFieldValidator>
                                    </div>
                                </div>
                            </div>
                            <div class="row col-md-10" id="pagoEfectivo">
                                <div class="row">
                                    <div class="col-md-10 mb-3">
                                        <div class="mb-3">
                                            <label for="txtPagoEfectivo">Monto a abonar</label>
                                            <div class="input-group">
                                                <div class="input-group-prepend">
                                                    <span class="input-group-text">$</span>
                                                </div>
                                                <asp:TextBox runat="server" ID="txtPagoEfectivo" CssClass="form-control col-md-8" placeholder="" type="number" min="1" step="any" AutoPostBack="True" OnTextChanged="txtPagoEfectivo_TextChanged"></asp:TextBox>
                                            </div>
                                             <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" CssClass="text-left" ControlToValidate="txtPagoEfectivo" ErrorMessage="RequiredFieldValidator" Font-Size="X-Small" SetFocusOnError="True"
                                                    ForeColor="Red" ValidationGroup="Verificar" Display="Dynamic">Campo obligatorio</asp:RequiredFieldValidator>
                                                <asp:Label ID="lblValidaPagoEfectivo" runat="server" CssClass="text-danger " Font-Size="X-Small"></asp:Label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    <asp:Button runat="server" ID="btnConfirmarPedido" CssClass="btn btn-primary" Text="Confirmar Pedido" OnClick="btnConfirmarPedido_Click" ValidationGroup="Verificar" />
                    <div class="row text-center">
                        <asp:Label ID="lblMensaje" runat="server" CssClass="text-danger"></asp:Label>
                    </div>
                </div>
            </div>
        </div>
        <script>
            window.onload = function () {
            };

            $("#MainContent_txtPagoEfectivo").change(function () {
                var pago = $("#MainContent_txtPagoEfectivo").val();
                var costo = $("#MainContent_txtCostoPedido").val();
                var comision = 30;
                var vuelto = pago - costo - comision
                if (vuelto < 0) {
                    $("#MainContent_txtVuelto").val("");
                    alert("El pago en efectivo no cubre el costo del pedido");
                }
                else
                    $("#MainContent_txtVuelto").val(pago - costo - comision);
            });


            function limitar(e, contenido, caracteres) {
                // obtenemos la tecla pulsada
                var unicode = e.keyCode ? e.keyCode : e.charCode;

                // Permitimos las siguientes teclas:
                // 8 backspace
                // 46 suprimir
                // 13 enter
                // 9 tabulador
                // 37 izquierda
                // 39 derecha
                // 38 subir
                // 40 bajar
                if (unicode == 8 || unicode == 46 || unicode == 13 || unicode == 9 || unicode == 37 || unicode == 39 || unicode == 38 || unicode == 40)
                    return true;

                // Si ha superado el limite de caracteres devolvemos false
                if (contenido.length >= caracteres)
                    return false;

                return true;
            }

        </script>
    </div>
</asp:Content>
