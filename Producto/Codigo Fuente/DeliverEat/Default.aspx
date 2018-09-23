<%@ Page Title="Inicio" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="DeliverEat.Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <section class="jumbotron text-center">
        <div class="container">
          <h1 class="jumbotron-heading">DeliverEat!</h1>
          <p class="lead text-muted">Servicio de delivery de lo que sea.</p>
            <p class="lead text-muted">Pedí cualquier cosa que entre en la mochila y nosotros te lo enviamos</p>
          <p>
            <%--<a href="#" class="btn btn-secondary my-2">Pedido Comercio Adherido</a>--%>
            <a href="PedidoLoQueSea.aspx" class="btn btn-primary my-2">Pedido Lo Que Sea</a>
          </p>
        </div>
      </section>
</asp:Content>
