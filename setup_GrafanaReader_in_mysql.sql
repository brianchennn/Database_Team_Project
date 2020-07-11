SHOW GLOBAL VARIABLES LIKE 'PORT';
--show what port the mysql instance is running on

CREATE USER 'GrafanaReader' IDENTIFIED BY 'grafana';
GRANT SELECT ON MLB.* to 'GrafanaReader';

GRANT SELECT ON MLB.atbats to 'GrafanaReader';
GRANT SELECT ON MLB.ejections to 'GrafanaReader';
GRANT SELECT ON MLB.games to 'GrafanaReader';
GRANT SELECT ON MLB.pitches to 'GrafanaReader';
GRANT SELECT ON MLB.player_names to 'GrafanaReader';


