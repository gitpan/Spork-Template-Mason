package Spork::Template::Mason;

use strict;

use vars qw($VERSION);

use Spoon::Template::Mason '-base';
use Spoon::Installer '-base';

$VERSION = 0.01;


1;

__DATA__
__template/autohandler__
<& top.mas, %ARGS &>
% $m->call_next;
<& bottom.mas, %ARGS &>
__template/top.mas__
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<html>
<head>
<title><% $slide_heading | h %></title>
<meta name="Content-Type" content="text/html; charset=utf-8">
<meta name="generator" content="<% $spork_version | h %>">
<link rel='stylesheet' href='slide.css' type='text/css'>
<link rel='icon' HREF='favicon.png'>
</head>
<body bgcolor="#ffffff" background="<% $background_image | h %>">
<div id="topbar">
<table width='100%'>
    <tr>
        <td width="13%"><img src="<% $presentation_graphic | h %>"></td>
        <td align="center" width="73%">
            <a href="<% $index_slide | h %>"><% $presentation_title | h %></a>
        </td>
        <td align="right" width="13%">
% if ($slide_num) {
         #<% $slide_num | h %>
% }
        </td>
    </tr>
</table>
</div>

<%args>
$slide_heading => ''
$spork_version => ''
$background_image => ''
$index_slide => ''
$presentation_graphic => ''
$presentation_title => ''
$slide_num => 0
</%args>
__template/bottom.mas__
<div id="bottombar">
<table width="100%">
    <tr>
        <td align="left" valign="middle">
<&| .no_empty_links &>
            <a href="<% $prev_slide | h %>">&lt;&lt; Previous</a> |
            <a href="<% $index_slide | h %>">Index</a> |
            <a href="<% $next_slide %>">Next &gt;&gt;</a>
</&>
        </td>
        <td align="right" valign="middle">
            <% $copyright_string %>
        </td>
    </tr>
</table>
</div> 
<div id="logo" />

</body>
</html>

<%args>
$prev_slide => ''
$index_slide => ''
$next_slide => ''
$copyright_string
</%args>

<%init>
$prev_slide ||= 'start.html'
    unless $m->request_comp->source_file =~ /start\.html/;
</%init>

<%def .no_empty_links>\
<% $c %>\
<%init>
my $c = $m->content;
$c =~ s{<a href="">([^<]+)</a>}{$1}g;
</%init>
</%def>
__template/index.html__
<div id="content"><p />
<ol>
% foreach my $slide (@slides) {
<li> <a href="<% $slide->{slide_name} | h %>"><% $slide->{slide_heading} | h %></a>
% }
</ol>
</div>

<%args>
@slides
</%args>
__template/start.html__
<div id="content"><p />
<center>
<h4><% $presentation_title | h %></h4>
<p />
<h4><% $author_name | h %></h4>
<h4><% $author_email | h %></h4>
<p />
<h4><% $presentation_place | h %></h4>
<h4><% $presentation_date | h %></h4>
</center>
</div>

<%args>
$presentation_title
$author_name => ''
$author_email => ''
$presentation_place => ''
$presentation_date => ''
</%args>
__template/slide.html__
<div id="content"><p />
<% $image_html %>
<% $slide_content %>
% unless ($last) {
<small>continued...</small>
% }
</div>

<%args>
$image_html
$slide_content
$last
</%args>
__template/slide.css__
hr {
    color: #202040;
    height: 0px;
    border-top: 0px;
    border-bottom: 3px #202040 ridge;
    border-left: 0px;
    border-right: 0px;
}

a:link {
    color: #123422;
    text-decoration: none;
}

a:visited {
    color: #123333;
    text-decoration: none;
}

a:hover {
    text-decoration: underline;
}

p {
    font-size: 24pt;
    margin: 6pt;
}

div p {
    font-size: 18pt;
    margin-top: 12pt;
    margin-bottom: 12pt;
    margin-left: 6pt;
    margin-right: 6pt;
}

small {
    font-size: 9pt;
    font-style: italic;
}

#topbar {
    background: <% $banner_bgcolor %>;
    color: blue;
    position:absolute;
    right: 5px;
    left: 5px;
    top: 5px;
}

#bottombar {
    background: <% $banner_bgcolor %>;
    color: blue;
    position: fixed;
    right: 5px;
    left: 5px;
    bottom: 5px;
    height: 50px;
    z-index: 0;
}

#content {
    background:#fff;
    margin-left: 20px;
    margin-right:20px;
    margin-top: 80px;
}


#logo {
    position: fixed;
    right: 40px;
    bottom: 51px;
    width: 130px;
    height: 150px;
    z-index:3;
    background-image: url(beastie.png);
    background-repeat: no-repeat;
}

<%args>
$banner_bgcolor
</%args>

<%flags>
inherit => undef
</%flags>

__END__

=head1 NAME

Spork::Template::Mason - Spork templating with Mason

=head1 SYNOPSIS

  # in your config.yaml file

  template_class: Spork::Template::Mason
  files_class: Spork::Template::Mason

=head1 DESCRIPTION

At present, this module's only purpose it to provide a default set of
Mason templates for Spork.  These templates are more or less identical
to the TT2 templates included in the main Spork distro.  You'll
probably want to customize these.

=head1 USAGE

Just set "template_class" and "files_class" in your F<config.yaml>
file to C<Spork::Template::Mason>.

=head1 SUPPORT

Support questions can be sent to me via email.

Please submit bugs to the CPAN RT system at
http://rt.cpan.org/NoAuth/ReportBug.html?Queue=spork-template-mason or
via email at bug-spork-template-mason@rt.cpan.org.

=head1 AUTHOR

Dave Rolsky <autarch@urth.org>

=head1 COPYRIGHT

This program is free software; you can redistribute
it and/or modify it under the same terms as Perl itself.

The full text of the license can be found in the
LICENSE file included with this module.

=cut
