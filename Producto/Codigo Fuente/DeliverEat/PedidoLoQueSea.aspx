<%@ Page Title="Pedido Comercio No Adherido" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PedidoLoQueSea.aspx.cs" Inherits="DeliverEat.PedidoLoQueSea" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <div class="py-5 text-center">
            <h2>Pedido Lo Que Sea - Paso 1</h2>
        </div>

        <div class="row">
            <div class="col-md-12 order-md-1">
                <h4 class="mb-3">Ingrese su pedido</h4>
                <div class="row">
                    <div class="col-md-12 mb-3">
                        <asp:TextBox runat="server" ID="txtPedido" CssClass="form-control" TextMode="MultiLine" Rows="5" cols="100" placeholder=""></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" CssClass="text-left" ControlToValidate="txtPedido" ErrorMessage="RequiredFieldValidator" Font-Size="X-Small" SetFocusOnError="True"
                            ForeColor="Red" ValidationGroup="Verificar" Display="Dynamic">Campo obligatorio</asp:RequiredFieldValidator>
                        <p>
                            <asp:Label AssociatedControlID="fileUploader1" runat="server" Text="Seleccionar imágenes:" />
                            <asp:FileUpload ID="fileUploader1" runat="server" AllowMultiple="True" />
                        </p>
                    </div>
                    <div class="col-md-4 mb-3">
                        <label for="txtCostoPedido">Costo Aproximado</label>
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text">$</span>
                            </div>
                            <asp:TextBox runat="server" ID="txtCostoPedido" CssClass="form-control col-md-5" placeholder="" type="number" min="0" step="any"></asp:TextBox>
                        </div>
                        <small class="text-muted">Si no es un pedido a un comercio, deje $0</small>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" CssClass="text-left" ControlToValidate="txtCostoPedido" ErrorMessage="RequiredFieldValidator" Font-Size="X-Small" SetFocusOnError="True"
                                ForeColor="Red" ValidationGroup="Verificar" Display="Dynamic">Campo obligatorio</asp:RequiredFieldValidator>
                    </div>
                </div>
                <h4 class="mb-3">Dirección de Retiro</h4>
                <div class="row">
                    <div class="col-md-4 mb-3">
                        <label for="txtCalle">Calle</label>
                        <asp:TextBox runat="server" ID="txtCalle" CssClass="form-control" placeholder=""></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" CssClass="text-left" ControlToValidate="txtCalle" ErrorMessage="RequiredFieldValidator" Font-Size="X-Small" SetFocusOnError="True"
                            ForeColor="Red" ValidationGroup="Verificar" Display="Dynamic">Campo obligatorio</asp:RequiredFieldValidator>
                    </div>
                    <div class="col-md-3 mb-3">
                        <label for="txtNumero">Número</label>
                        <asp:TextBox runat="server" ID="txtNumero" CssClass="form-control col-md-6" placeholder="" type="number"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" CssClass="text-left" ControlToValidate="txtNumero" ErrorMessage="RequiredFieldValidator" Font-Size="X-Small" SetFocusOnError="True"
                            ForeColor="Red" ValidationGroup="Verificar" Display="Dynamic">Campo obligatorio</asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="mb-3">
                    <label for="txtCodPostal">Código Postal</label>
                    <asp:TextBox runat="server" ID="txtCodPostal" CssClass="form-control col-md-2" placeholder=""></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" CssClass="text-left" ControlToValidate="txtCodPostal" ErrorMessage="RequiredFieldValidator" Font-Size="X-Small" SetFocusOnError="True"
                        ForeColor="Red" ValidationGroup="Verificar" Display="Dynamic">Campo obligatorio</asp:RequiredFieldValidator>
                </div>
                <div class="row">
                    <div class="col-md-2 mb-3">
                        <label for="txtPiso">Piso</label>
                        <asp:TextBox runat="server" ID="txtPiso" CssClass="form-control" placeholder="" type="number"></asp:TextBox>
                    </div>
                    <div class="col-md-2 mb-3">
                        <label for="txtDepartamento">Departamento</label>
                        <asp:TextBox runat="server" ID="txtDepartamento" CssClass="form-control" placeholder=""></asp:TextBox>
                    </div>
                </div>
                <div class="mb-3">
                    <div class="checkbox">
                        <label>
                            <asp:CheckBox ID="cbMapa" runat="server" OnCheckedChanged="cbMapa_CheckedChanged" AutoPostBack="True" />
                            Seleccionar dirección desde mapa
                        </label>
                    </div>
                </div>
                <div class="mb-3" id="Mapas">
                    <div class="row">
                        <div class="col-md-6">
                            <div id="map" style="height: 400px; width: 100%;"></div>
                        </div>
                        <div class="col-md-6">
                            <div id="pano" style="height: 400px; width: 100%;"></div>
                        </div>
                    </div>
                    <div class="mb-3">
                        <asp:TextBox runat="server" ID="txtCoordenadas" CssClass="form-control"></asp:TextBox>
                    </div>
                </div>
                <asp:Button runat="server" ID="btnSiguiente" CssClass="btn btn-primary" Text="Siguiente" ValidationGroup="Verificar" OnClick="btnSiguiente_Click" />
                <div class="row text-center">
                    <asp:Label ID="lblMensaje" runat="server" CssClass="text-danger"></asp:Label>
                </div>
            </div>
        </div>
    </div>
    <script>
        window.onload = function () {
            var campo = document.getElementById('<%=txtCoordenadas.ClientID%>');
            campo.readOnly = true;
            if ($("#MainContent_cbMapa").is(':checked')) {
                $("#Mapas").show(500);
            }
            else {
                $("#Mapas").hide();
            }

        };

        function initialize() {
            var fenway = { lat: -31.4168272, lng: -64.1857908 };
            var map = new google.maps.Map(document.getElementById('map'), {
                center: fenway,
                zoom: 14
            });
            var panorama = new google.maps.StreetViewPanorama(
                document.getElementById('pano'), {
                    position: fenway,
                    pov: {
                        heading: 34,
                        pitch: 10
                    }
                });
            map.setStreetView(panorama);

            google.maps.event.addListener(panorama, 'position_changed', function () {
                $("#MainContent_txtCoordenadas").val(panorama.getPosition().toString());
            });
        }

    </script>
    <script async defer
        src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDOVmgMrLBpBMmHRlu7hqX7Ti3g-mmhiEE&callback=initialize">
    </script>
</asp:Content>
